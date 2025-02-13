import { TableSort } from 'components/Table/TableSort';
import _ from 'lodash';
import queryString from 'query-string';
import React, { useCallback, useEffect, useState } from 'react';
import { useDispatch } from 'react-redux';
import { useHistory } from 'react-router-dom';
import { useAppSelector } from 'store/hooks';
import { saveFilter } from 'store/slices/filter/filterSlice';
import { generateMultiSortCriteria, resolveSortCriteriaFromUrl } from 'utils';

/**
 * Extract the specified properties from the source object.
 * Does not extract 'undefined' property values.
 * This provides a consistent deconstructor implementation.
 * For some reason the following will not work `const result: T = source;`.
 * @param props An array of property names.
 * @param source The source object that the properties will be extracted from.
 * @returns A new object composed of the extracted properties.
 */
const extractProps = (props: string[], source: any): any => {
  var dest = {} as any;
  props.forEach(p => {
    if (source[p] !== undefined) {
      if (source[p] === 'true') {
        dest[p] = true;
      } else if (source[p] === 'false') {
        dest[p] = false;
      } else {
        dest[p] = source[p];
      }
    }
  });
  return dest;
};

const defaultFilter = {
  address: '',
  pid: '',
  pin: '',
  searchBy: 'pid',
};

/**
 * RouterFilter hook properties.
 */
export interface IRouterFilterProps<T> {
  /** Initial filter that will be applied to the URL and stored in redux. */
  filter: T;
  /** Change the state of the filter. */
  setFilter: null | ((filter: T) => void);
  /** Redux key */
  key: string;
  sort?: TableSort<any>;
  setSorting?: (sort: TableSort<any>) => void;
}

/**
 * A generic hook that will extract the query parameters from the URL, store them in a redux store
 * and update the URL any time the specified 'filter' is updated.
 * On Mount it will extract the URL query parameters or pull from the redux store and set the specified 'filter'.
 *
 * The filter type of 'T' should be a flat object with properties that are only string.
 * NOTE: URLSearchParams not supported by IE.
 */
export const useRouterFilter = <T extends object>({
  filter,
  setFilter,
  key,
  sort,
  setSorting,
}: IRouterFilterProps<T>) => {
  const history = useHistory();
  const reduxSearch = useAppSelector(state => state.filter);
  const [savedFilter] = useState(reduxSearch);
  const dispatch = useDispatch();
  const [loaded, setLoaded] = useState(false);

  // Extract the query parameters to initialize the filter.
  // This will only occur the first time the component loads to ensure the URL query parameters are applied.
  useEffect(() => {
    if (setFilter) {
      const params = queryString.parse(history.location.search);
      // Check if query contains filter params.
      const filterProps = Object.keys(filter);
      if (_.intersection(Object.keys(params), filterProps).length) {
        let merged = { ...defaultFilter, ...extractProps(filterProps, params) };
        // Only change state if the query parameters are different than the default filter.
        if (!_.isEqual(merged, filter)) setFilter(merged);
      } else if (savedFilter?.hasOwnProperty(key)) {
        let merged = { ...defaultFilter, ...extractProps(filterProps, savedFilter[key]) };
        // Only change state if the saved filter is different than the default filter.
        if (!_.isEqual(merged, filter)) setFilter(merged);
      }

      if (params.sorting && setSorting) {
        const urlSort = resolveSortCriteriaFromUrl(
          typeof params.sorting === 'string' ? [params.sorting] : params.sorting,
        );
        if (!_.isEmpty(urlSort)) {
          setSorting(urlSort as any);
        }
      }
      setLoaded(true);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [history.location.pathname]);

  // If the 'filter' changes save it to redux store and update the URL.
  React.useEffect(() => {
    if (loaded) {
      const filterParams = new URLSearchParams(filter as any);
      const sorting = generateMultiSortCriteria(sort!);
      const allParams = {
        ...queryString.parse(history.location.search),
        ...queryString.parse(filterParams.toString()),
        sorting,
      };
      history.push({
        pathname: history.location.pathname,
        search: queryString.stringify(allParams, { skipEmptyString: true, skipNull: true }),
      });
      const keyedFilter = { [key]: filter };
      dispatch(saveFilter({ ...savedFilter, ...keyedFilter }));
    }
  }, [history, key, filter, savedFilter, dispatch, sort, loaded]);

  const updateSearch = useCallback(
    (newFilter: T) => {
      const filterParams = new URLSearchParams(newFilter as any);
      const sorting = generateMultiSortCriteria(sort!);
      const allParams = {
        ...queryString.parse(history.location.search),
        ...queryString.parse(filterParams.toString()),
        sort: sorting,
      };
      history.push({
        pathname: history.location.pathname,
        search: queryString.stringify(allParams, { skipEmptyString: true, skipNull: true }),
      });
      const keyedFilter = { [key]: newFilter };
      dispatch(saveFilter({ ...savedFilter, ...keyedFilter }));
    },
    [history, key, savedFilter, dispatch, sort],
  );

  return {
    updateSearch,
  };
};
