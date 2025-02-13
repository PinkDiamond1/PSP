import { useKeycloak } from '@react-keycloak/web';
import { Claims } from 'constants/claims';
import { noop } from 'lodash';
import { mockDocumentsResponse } from 'mocks/mockDocuments';
import { cleanup, mockKeycloak, render, RenderOptions } from 'utils/test-utils';

import { DocumentResults, IDocumentResultProps } from './DocumentResults';

const setSort = jest.fn();

// mock auth library
jest.mock('@react-keycloak/web');

(useKeycloak as jest.Mock).mockReturnValue({
  keycloak: {
    userInfo: {
      organizations: [1],
      roles: [],
    },
    subject: 'test',
  },
});

// render component under test
const setup = (renderOptions: RenderOptions & Partial<IDocumentResultProps> = { results: [] }) => {
  const { results, ...rest } = renderOptions;
  const utils = render(
    <DocumentResults
      sort={{}}
      results={results ?? []}
      setSort={setSort}
      onViewDetails={noop}
      onDelete={noop}
    />,
    {
      ...rest,
    },
  );
  const tableRows = utils.container.querySelectorAll('.table .tbody .tr-wrapper');
  // long css selector to: get the FIRST header or table, then get the SVG up/down sort buttons
  const sortButtons = utils.container.querySelector(
    '.table .thead .tr .sortable-column div',
  ) as HTMLElement;
  return {
    ...utils,
    tableRows,
    sortButtons,
  };
};

describe('Document Results Table', () => {
  beforeEach(() => {
    mockKeycloak({ claims: [] });
    setSort.mockClear();
  });
  afterEach(() => {
    cleanup();
  });
  afterAll(() => {
    jest.restoreAllMocks();
  });

  it('matches snapshot', async () => {
    const { asFragment } = setup({ results: mockDocumentsResponse() });
    expect(asFragment()).toMatchSnapshot();
  });

  it('displays a message when no matching records found', async () => {
    const { tableRows, findAllByText } = setup({ results: [] });

    expect(tableRows.length).toBe(0);
    const toasts = await findAllByText('No matching Documents found');
    expect(toasts[0]).toBeVisible();
  });

  it('displays document view button', async () => {
    mockKeycloak({ claims: [Claims.DOCUMENT_VIEW, Claims.DOCUMENT_EDIT] });
    const { getByTestId } = setup({ results: mockDocumentsResponse() });

    const dButton = await getByTestId('document-view-button');
    expect(dButton).toBeVisible();
  });

  it('displays document delete button', async () => {
    mockKeycloak({ claims: [Claims.DOCUMENT_VIEW, Claims.DOCUMENT_DELETE] });
    const { getByTestId } = setup({ results: mockDocumentsResponse() });

    const dButton = await getByTestId('document-delete-button');
    expect(dButton).toBeVisible();
  });
});
