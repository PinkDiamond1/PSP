import * as Styled from 'components/common/styles';
import {
  MapCursors,
  SelectedPropertyContext,
} from 'components/maps/providers/SelectedPropertyContext';
import { Section } from 'features/mapSideBar/tabs/Section';
import * as React from 'react';

import MapClickMonitor from '../components/MapClickMonitor';
import { IMapProperty } from '../models';
import PropertyMapSelectorSubForm from './PropertyMapSelectorSubForm';

export interface IPropertyMapSelectorFormViewProps {
  onSelectedProperty: (property: IMapProperty) => void;
}

const PropertyMapSelectorFormView: React.FunctionComponent<IPropertyMapSelectorFormViewProps> = ({
  onSelectedProperty,
}) => {
  const { setCursor } = React.useContext(SelectedPropertyContext);

  const [selectedProperty, setSelectedProperty] = React.useState<IMapProperty | undefined>(
    undefined,
  );

  const onClickDraftMarker = () => {
    setCursor(MapCursors.DRAFT);
  };

  const onClickAway = () => {
    setCursor(undefined);
  };

  const addProperty = (property: IMapProperty) => {
    setSelectedProperty(property);
    onSelectedProperty(property);
  };
  return (
    <>
      <Section header={undefined}>
        <Styled.H3>Select a property</Styled.H3>
        <PropertyMapSelectorSubForm
          onClickDraftMarker={onClickDraftMarker}
          onClickAway={onClickAway}
          selectedProperty={selectedProperty}
        />
        <MapClickMonitor addProperty={addProperty} />
      </Section>
    </>
  );
};

export default PropertyMapSelectorFormView;
