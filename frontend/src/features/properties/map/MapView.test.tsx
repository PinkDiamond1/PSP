import { useKeycloak } from '@react-keycloak/web';
import { cleanup, fireEvent, render, screen, waitFor, within } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import axios from 'axios';
import MockAdapter from 'axios-mock-adapter';
import { useLayerQuery } from 'components/maps/leaflet/LayerPopup';
import { createPoints } from 'components/maps/leaflet/mapUtils';
import {
  Claims,
  PropertyAreaUnitTypes,
  PropertyClassificationTypes,
  PropertyDataSourceTypes,
  PropertyStatusTypes,
  PropertyTenureTypes,
} from 'constants/index';
import { createMemoryHistory } from 'history';
import { useProperties } from 'hooks';
import { useApiProperties } from 'hooks/pims-api';
import { useLtsa } from 'hooks/useLtsa';
import { usePropertyAssociations } from 'hooks/usePropertyAssociations';
import { IProperty } from 'interfaces';
import configureMockStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import leafletMouseSlice from 'store/slices/leafletMouse/LeafletMouseSlice';
import { lookupCodesSlice } from 'store/slices/lookupCodes';
import { mockKeycloak } from 'utils/test-utils';
import TestCommonWrapper from 'utils/TestCommonWrapper';

import { useMapProperties } from './hooks/useMapProperties';
import MapView from './MapView';

const mockAxios = new MockAdapter(axios);
jest.mock('@react-keycloak/web');
const mockStore = configureMockStore([thunk]);
jest.mock('./hooks/useMapProperties');
jest.mock('components/maps/leaflet/LayerPopup');
jest.mock('hooks/useProperties');
jest.mock('hooks/usePropertyAssociations');
jest.mock('hooks/pims-api');
jest.mock('hooks/useLtsa');

const ltsaMock = {
  getLtsaData: jest.fn(),
  ltsaLoading: false,
};
(useLtsa as any).mockImplementation(() => ltsaMock);

(useProperties as any).mockImplementation(() => ({
  deleteParcel: jest.fn(),
  deleteBuilding: jest.fn(),
  updateParcel: jest.fn(),
  createParcel: jest.fn(),
  fetchPropertyDetail: jest.fn(),
  fetchBuildingDetail: jest.fn(),
  fetchParcelDetail: jest.fn(),
  fetchParcelsDetail: jest.fn(),
  fetchParcels: jest.fn(),
  getPropertyWithPid: jest.fn(),
}));

(usePropertyAssociations as any).mockImplementation(() => ({
  getPropertyAssociations: jest.fn(),
}));

const largeMockParcels = [
  { id: 1, latitude: 53.917061, longitude: -122.749672 },
  { id: 2, latitude: 53.917062, longitude: -122.749672 },
  { id: 3, latitude: 53.917063, longitude: -122.749672 },
  { id: 4, latitude: 53.917064, longitude: -122.749672 },
  { id: 5, latitude: 53.917065, longitude: -122.749672 },
  { id: 6, latitude: 53.917066, longitude: -122.749672 },
  { id: 7, latitude: 53.917067, longitude: -122.749672 },
  { id: 8, latitude: 53.917068, longitude: -122.749672 },
  { id: 9, latitude: 53.917069, longitude: -122.749672 },
  { id: 10, latitude: 53.917071, longitude: -122.749672 },
  { id: 11, latitude: 53.918172, longitude: -122.749772 },
] as IProperty[];

// This mocks the parcels of land a user can see - render a cluster and a marker
const smallMockParcels = [
  { id: 1, latitude: 54.917061, longitude: -122.749672 },
  { id: 3, latitude: 54.918162, longitude: -122.749772 },
] as IProperty[];

// This mocks the parcels of land a user can see - render a cluster and a marker
const mockParcels = [
  { id: 1, latitude: 55.917061, longitude: -122.749672, pid: '7771' },
  { id: 2, latitude: 55.917062, longitude: -122.749672, pid: '7772' },
  { id: 3, latitude: 55.917063, longitude: -122.749772, pid: '7773' },
] as IProperty[];

const useLayerQueryMock = {
  findOneWhereContains: jest.fn(),
  findMetadataByLocation: jest.fn(),
};
(useLayerQuery as jest.Mock).mockReturnValue(useLayerQueryMock);

// This will spoof the active parcel (the one that will populate the popup details)
const mockDetails = {
  propertyDetail: {
    id: 1,
    pid: '000-000-001',
    pin: '',
    statusId: PropertyStatusTypes.UnderAdmin,
    dataSourceId: PropertyDataSourceTypes.PAIMS,
    dataSourceEffectiveDate: new Date(),
    classificationId: PropertyClassificationTypes.CoreStrategic,
    classification: 'Core Operational',
    tenureId: PropertyTenureTypes.HighwayRoad,
    name: 'test name',
    description: 'test',
    encumbranceReason: '',
    zoning: '',
    zoningPotential: '',
    latitude: 48,
    longitude: 123,
    isSensitive: false,
    evaluations: [
      {
        evaluatedOn: '2019',
        key: 1,
        value: 100000,
      },
    ],
    regionId: 1,
    districtId: 1,
    address: {
      streetAddress1: '1234 mock Street',
      streetAddress2: 'N/A',
      municipality: '',
      provinceId: 1,
      postal: 'V1V1V1',
    },
    areaUnitId: PropertyAreaUnitTypes.Hectare,
    landArea: 0,
    landLegalDescription: 'test',
  },
};

const store = mockStore({
  [lookupCodesSlice.name]: { lookupCodes: [] },
  [leafletMouseSlice.name]: { propertyDetail: mockDetails },
});

let history = createMemoryHistory();
describe('MapView', () => {
  const onMarkerClick = jest.fn();

  beforeEach(() => {
    useLayerQueryMock.findMetadataByLocation.mockResolvedValue({});
    (useKeycloak as jest.Mock).mockReturnValue({
      keycloak: {
        userInfo: {
          roles: ['property-edit', 'property-view'],
          organizations: [0],
        },
      },
    });
    ((useMapProperties as unknown) as jest.Mock<Partial<typeof useMapProperties>>).mockReturnValue({
      loadProperties: {
        execute: jest.fn().mockResolvedValue({
          features: createPoints(mockParcels),
          type: 'FeatureCollection',
          bbox: undefined,
        }),
      },
    });
    ((useApiProperties as unknown) as jest.Mock<Partial<typeof useApiProperties>>).mockReturnValue({
      getProperty: async () => {
        return {} as IProperty;
      },
    });
    delete (window as any).ResizeObserver;
    window.ResizeObserver = jest.fn().mockImplementation(() => ({
      observe: jest.fn(),
      unobserve: jest.fn(),
      disconnect: jest.fn(),
    }));
    onMarkerClick.mockClear();
    mockAxios.reset();
    jest.clearAllMocks();
    mockAxios.onAny().reply(200);
    history = createMemoryHistory();
  });

  afterEach(cleanup);

  const getMap = () => {
    process.env.REACT_APP_TENANT = 'MOTI';
    const onMarkerPopupClosed = jest.fn();
    return (
      <TestCommonWrapper store={store} history={history}>
        <MapView showParcelBoundaries={true} onMarkerPopupClosed={onMarkerPopupClosed} />
      </TestCommonWrapper>
    );
  };

  it('Renders the map', async () => {
    await waitFor(() => {
      const { asFragment } = render(getMap());
      expect(asFragment()).toMatchSnapshot();
    });
    expect(document.querySelector('.leaflet-container')).toBeVisible();
  });

  it('Can toggle the base map', async () => {
    mockAxios.reset();
    mockAxios.onGet('/basemaps.json').reply(200, {
      basemaps: [
        {
          name: 'BC Roads',
          url:
            'https://maps.gov.bc.ca/arcgis/rest/services/province/roads_wm/MapServer/tile/{z}/{y}/{x}',
          attribution: '&copy; Government of British Columbia, DataBC, GeoBC',
          thumbnail: '/streets.jpg',
        },
        {
          name: 'Satellite',
          url:
            'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
          attribution:
            'Tiles &copy; Esri &mdash; Source: Esri, DigitalGlobe, GeoEye, Earthstar Geographics, CNES/Airbus DS, USDA, USGS, AeroGRID, IGN, and the GIS User Community',
          thumbnail: '/satellite.jpg',
        },
      ],
    });
    mockAxios.onAny().reply(200, {});
    await waitFor(() => render(getMap()));
    // find basemap toggle button
    const basemapButton = document.querySelector<HTMLElement>('.basemap-item-button.secondary');
    expect(basemapButton).toBeDefined();
    const { getByAltText } = within(basemapButton!);
    const image = getByAltText('Map Thumbnail');
    expect(image).toHaveAttribute('src', '/satellite.jpg');
    // click it
    fireEvent.click(basemapButton!);
    // expect image to change
    expect(image).toHaveAttribute('src', '/streets.jpg');
  });

  it('Renders markers when provided', async () => {
    await waitFor(() => render(getMap()));
    expect(document.querySelector('.leaflet-marker-icon')).toBeVisible();
  });

  it('the map can zoom in until no clusters are visible', async () => {
    ((useMapProperties as unknown) as jest.Mock<Partial<typeof useMapProperties>>).mockReturnValue({
      loadProperties: {
        execute: jest.fn().mockResolvedValue({
          features: createPoints(smallMockParcels),
          type: 'FeatureCollection',
          bbox: undefined,
        }),
      },
    });
    ((useApiProperties as unknown) as jest.Mock<Partial<typeof useApiProperties>>).mockReturnValue({
      getParcel: async () => {
        return {} as IProperty;
      },
    });

    const { container } = render(getMap());

    await waitFor(() => {
      const icon = container.querySelector('.leaflet-control-zoom-in');
      fireEvent.click(icon!);
      const cluster = container.querySelector('.leaflet-marker-icon.marker-cluster');
      expect(cluster).toBeNull();
    });
  });

  it('the map can handle features with invalid geometry', async () => {
    ((useMapProperties as unknown) as jest.Mock<Partial<typeof useMapProperties>>).mockReturnValue({
      loadProperties: {
        execute: jest.fn().mockResolvedValue({
          features: createPoints(smallMockParcels).map(feature => ({ ...feature, geometry: null })),
          type: 'FeatureCollection',
          bbox: undefined,
        }),
      },
    });
    ((useApiProperties as unknown) as jest.Mock<Partial<typeof useApiProperties>>).mockReturnValue({
      getParcel: async () => {
        return {} as IProperty;
      },
    });
    const { findByText } = render(getMap());

    expect(await findByText('No search results found')).toBeVisible();
  });

  it('the map can zoom out until the markers are clustered', async () => {
    const { container } = render(getMap());
    await waitFor(() => {
      const icon = container.querySelector('.leaflet-control-zoom-out');
      userEvent.click(icon!);
      const cluster = container.querySelector('.leaflet-marker-icon.marker-cluster');
      expect(cluster).toBeVisible();
    });
  });

  it('clusters can be clicked to zoom and spiderfy', async () => {
    const { container } = render(getMap());
    await waitFor(() => {
      const icon = container.querySelector('.leaflet-control-zoom-out');
      fireEvent.click(icon!);
      const cluster = container.querySelector('.leaflet-marker-icon.marker-cluster');
      expect(cluster).toBeVisible();
      fireEvent.click(cluster!);
    });
    await waitFor(() => {
      const cluster = container.querySelector('.leaflet-marker-icon.marker-cluster');
      expect(cluster).toBeVisible();
      fireEvent.click(cluster!);
      const polyline = container.querySelector('.leaflet-pane.leaflet-overlay-pane svg g');
      expect(polyline).toBeVisible();
    });
  });

  it('the map can be clicked', async () => {
    useLayerQueryMock.findOneWhereContains.mockResolvedValue({
      features: [
        {
          type: 'Feature',
          geometry: { type: 'Point', coordinates: [-1.133005, 52.629835] },
          properties: {},
        },
      ],
    });
    const { container } = render(getMap());
    await waitFor(() => {
      const map = container.querySelector('.leaflet-container');
      expect(map).toBeVisible();
      fireEvent.click(map!);
    });
    expect(useLayerQueryMock.findOneWhereContains).toHaveBeenLastCalledWith({
      lat: 52.81604319154934,
      lng: -124.67285156250001,
    });
  });

  xit('When the map is clicked, the resulting popup can be closed', async () => {
    useLayerQueryMock.findOneWhereContains.mockResolvedValue({
      features: [
        {
          type: 'Feature',
          geometry: { type: 'Point', coordinates: [-1.133005, 52.629835] },
          properties: { pid: '123-456-789' },
        },
      ],
    });
    const { container } = render(getMap());
    await waitFor(() => {
      const map = container.querySelector('.leaflet-container');
      expect(map).toBeVisible();
      userEvent.click(map!);
    });
    expect(useLayerQueryMock.findOneWhereContains).toHaveBeenLastCalledWith({
      lat: 52.81604319154934,
      lng: -124.67285156250001,
    });
    const closeButton = container.querySelector('.leaflet-popup-close-button');
    fireEvent.click(closeButton!);
    const layerPopup = container.querySelector('.leaflet-popup');
    expect(layerPopup).not.toBeInTheDocument();
  });

  it('clusters can be clicked to zoom and spiderfy large clusters', async () => {
    ((useApiProperties as unknown) as jest.Mock<Partial<typeof useApiProperties>>).mockReturnValue({
      getProperty: async () => {
        return {} as IProperty;
      },
    });
    ((useMapProperties as unknown) as jest.Mock<Partial<typeof useMapProperties>>).mockReturnValue({
      loadProperties: {
        execute: jest.fn().mockResolvedValue({
          features: createPoints(largeMockParcels),
          type: 'FeatureCollection',
          bbox: undefined,
        }),
      },
    });
    const { container } = render(getMap());
    await waitFor(() => {
      const icon = container.querySelector('.leaflet-control-zoom-out');
      fireEvent.click(icon!);
      const cluster = container.querySelector('.leaflet-marker-icon.marker-cluster');
      expect(cluster).toBeVisible();
      fireEvent.click(cluster!);
    });
    await waitFor(() => {
      const cluster = container.querySelector('.leaflet-marker-icon.marker-cluster');
      expect(cluster).toBeVisible();
      fireEvent.click(cluster!);
      const polyline = container.querySelector('.leaflet-pane.leaflet-overlay-pane svg g');
      expect(polyline).toBeVisible();
    });
  });

  it('Rendered markers can be clicked normally', async () => {
    await waitFor(() => render(getMap()));
    const cluster = document.querySelector('.leaflet-marker-icon');
    fireEvent.click(cluster!);
    const marker = document.querySelector('img.leaflet-marker-icon');
    fireEvent.click(marker!);
    const text = await screen.findByText('Property Information');
    expect(text).toBeVisible();
  });

  it('Rendered markers can be clicked and displayed with permissions', async () => {
    mockKeycloak({ claims: [Claims.ADMIN_PROPERTIES] });
    await waitFor(() => render(getMap()));
    const cluster = document.querySelector('.leaflet-marker-icon');
    fireEvent.click(cluster!);
    const marker = document.querySelector('img.leaflet-marker-icon');
    fireEvent.click(marker!);
    const text = await screen.findByText('Property Information');
    expect(text).toBeVisible();
  });

  it('Rendered markers can be clicked which hides the filter', async () => {
    await waitFor(() => render(getMap()));
    const cluster = document.querySelector('.leaflet-marker-icon');
    fireEvent.click(cluster!);
    const marker = document.querySelector('img.leaflet-marker-icon');
    fireEvent.click(marker!);
    const text = await screen.findByText('Property Information');
    expect(text).toBeVisible();
    const label = await screen.queryByText('Search:');
    expect(label).toBeNull();
  });
});
