import { screen } from '@testing-library/react';
import axios from 'axios';
import MockAdapter from 'axios-mock-adapter';
import Claims from 'constants/claims';
import { createMemoryHistory } from 'history';
import { mockLookups } from 'mocks';
import { mockActivitiesResponse } from 'mocks/mockActivities';
import { lookupCodesSlice } from 'store/slices/lookupCodes';
import {
  render,
  RenderOptions,
  userEvent,
  waitFor,
  waitForElementToBeRemoved,
} from 'utils/test-utils';

import ActivityListView, { IActivityListViewProps } from './ActivityListView';

const mockAxios = new MockAdapter(axios);
const storeState = {
  [lookupCodesSlice.name]: { lookupCodes: mockLookups },
};
const mockTemplateTypes = [
  { id: 1, activityTemplateTypeCode: { id: 'GENERAL', description: 'General' } },
];

const history = createMemoryHistory();
jest.mock('@react-keycloak/web');

describe('Activity List View', () => {
  const setup = (renderOptions?: RenderOptions & Partial<IActivityListViewProps>) => {
    // render component under test
    const component = render(<ActivityListView fileId={1} />, {
      ...renderOptions,
      store: storeState,
      history: history,
      claims: renderOptions?.claims ?? [],
    });

    return {
      ...component,
    };
  };

  beforeAll(() => {
    mockAxios
      .onGet(new RegExp(`/researchFiles/activity-templates/*`))
      .reply(200, mockTemplateTypes);
    mockAxios
      .onGet(new RegExp(`/researchFiles/1/activities/*`))
      .reply(200, mockActivitiesResponse());
    mockAxios.onAny().reply(200, {});
  });
  it('renders as expected', async () => {
    const { asFragment, getByTitle } = setup({
      claims: [Claims.ACTIVITY_VIEW, Claims.ACTIVITY_DELETE],
    });
    await waitForElementToBeRemoved(getByTitle('table-loading'));
    const fragment = await waitFor(() => asFragment());
    expect(fragment).toMatchSnapshot();
  });

  it('should have the activity type in the component', () => {
    const { getByTestId } = setup({ claims: [Claims.ACTIVITY_ADD] });
    expect(getByTestId('add-activity-type')).toBeInTheDocument();
  });

  it('should not display the view icon/link unless the user has the correct claim', async () => {
    const { getByTitle, queryAllByTitle, queryByText } = setup();
    await waitForElementToBeRemoved(getByTitle('table-loading'));
    const icon = queryAllByTitle('View Activity');
    const link = queryByText('Survey');
    expect(icon).toHaveLength(0);
    expect(link).not.toHaveClass('btn-link');
  });

  it('should allow an activity to be viewed by clicking the icon', async () => {
    const { getByTitle, getAllByTitle } = setup({
      claims: [Claims.ACTIVITY_VIEW, Claims.ACTIVITY_DELETE],
    });
    await waitForElementToBeRemoved(getByTitle('table-loading'));
    const link = getAllByTitle('View Activity')[0];
    userEvent.click(link);
    expect(history.location.pathname).toBe('/activity/1');
  });

  it('should allow an activity to be viewed by clicking the link', async () => {
    const { getByTitle, getByText } = setup({
      claims: [Claims.ACTIVITY_VIEW, Claims.ACTIVITY_DELETE],
    });
    await waitForElementToBeRemoved(getByTitle('table-loading'));
    const link = getByText('Survey');

    userEvent.click(link);
    expect(history.location.pathname).toBe('/activity/1');
  });

  it('should not show the delete icon unless the user has the correct claim', async () => {
    const { getByTitle, queryAllByTitle } = setup();
    await waitForElementToBeRemoved(getByTitle('table-loading'));
    const deleteButton = queryAllByTitle('Delete Activity');

    expect(deleteButton).toHaveLength(0);
  });

  it('should show the delete modal when an activity is deleted', async () => {
    const { getByTitle, getAllByTitle } = setup({
      claims: [Claims.ACTIVITY_VIEW, Claims.ACTIVITY_DELETE],
    });
    await waitForElementToBeRemoved(getByTitle('table-loading'));
    const deleteButton = getAllByTitle('Delete Activity')[0];

    userEvent.click(deleteButton);
    expect(await screen.findByText(/You have chosen to delete this activity/g)).toBeVisible();
  });

  it('should delete the activity if the delete modal is confirmed', async () => {
    const { getByTitle, getAllByTitle } = setup({
      claims: [Claims.ACTIVITY_VIEW, Claims.ACTIVITY_DELETE],
    });
    await waitForElementToBeRemoved(getByTitle('table-loading'));
    const deleteButton = getAllByTitle('Delete Activity')[0];
    userEvent.click(deleteButton);
    expect(await screen.findByText(/You have chosen to delete this activity/g)).toBeVisible();
    const continueButton = await screen.findByText('Continue');

    userEvent.click(continueButton);
    await waitFor(async () => {
      expect(mockAxios.history.delete[0].url).toBe('/activities/1');
    });
  });
  it('should close the delete modal if deletion is cancelled', async () => {
    const { getByTitle, getAllByTitle } = setup({
      claims: [Claims.ACTIVITY_VIEW, Claims.ACTIVITY_DELETE],
    });
    await waitForElementToBeRemoved(getByTitle('table-loading'));
    const deleteButton = getAllByTitle('Delete Activity')[0];
    userEvent.click(deleteButton);
    expect(await screen.findByText(/You have chosen to delete this activity/g)).toBeVisible();
    const cancelButton = await screen.findByText('Cancel');

    userEvent.click(cancelButton);
    await waitFor(async () => {
      expect(screen.queryByText(/You have chosen to delete this activity/g)).toBeNull();
    });
  });
});
