import { AxiosError, AxiosResponse } from 'axios';
import { useApiDocuments } from 'hooks/pims-api/useApiDocuments';
import { useApiRequestWrapper } from 'hooks/pims-api/useApiRequestWrapper';
import { IApiError } from 'interfaces/IApiError';
import {
  Api_Storage_DocumentMetadata,
  DocumentQueryResult,
  FileDownload,
} from 'models/api/DocumentStorage';
import { ExternalResult } from 'models/api/ExternalResult';
import { useCallback } from 'react';
import { toast } from 'react-toastify';

/**
 * hook that retrieves document information.
 */
export const useDocumentProvider = () => {
  const {
    getDocumentMetada,
    downloadDocumentFileApiCall,
    downloadDocumentFileLatestApiCall,
  } = useApiDocuments();

  // Provides functionality to retrieve document metadata information
  const {
    execute: retrieveDocumentMetadata,
    loading: retrieveDocumentMetadataLoading,
  } = useApiRequestWrapper<
    (
      mayanDocumentId: number,
    ) => Promise<
      AxiosResponse<ExternalResult<DocumentQueryResult<Api_Storage_DocumentMetadata>>, any>
    >
  >({
    requestFunction: useCallback(
      async (mayanDocumentId: number) => await getDocumentMetada(mayanDocumentId),
      [getDocumentMetada],
    ),
    requestName: 'retrieveDocumentMetadata',
    onSuccess: useCallback(() => toast.success('Document Metadata retrieved'), []),
    onError: useCallback((axiosError: AxiosError<IApiError>) => {
      if (axiosError?.response?.status === 400) {
        toast.error(axiosError?.response.data.error);
      } else {
        toast.error('Retrieve document metadata file error. Check responses and try again.');
      }
    }, []),
  });

  // Provides functionality for download a document file
  const {
    execute: downloadDocumentFile,
    loading: downloadDocumentFileLoading,
  } = useApiRequestWrapper<
    (
      mayanDocumentId: number,
      mayanFileId: number,
    ) => Promise<AxiosResponse<ExternalResult<FileDownload>, any>>
  >({
    requestFunction: useCallback(
      async (mayanDocumentId: number, mayanFileId: number) =>
        await downloadDocumentFileApiCall(mayanDocumentId, mayanFileId),
      [downloadDocumentFileApiCall],
    ),
    requestName: 'DownloadDocumentFile',
    onSuccess: useCallback(() => toast.success('Download Downloaded'), []),
    onError: useCallback((axiosError: AxiosError<IApiError>) => {
      if (axiosError?.response?.status === 400) {
        toast.error(axiosError?.response.data.error);
      } else {
        toast.error('Download document error. Check responses and try again.');
      }
    }, []),
  });

  // Provides functionality for download the latest file for a document
  const {
    execute: downloadDocumentFileLatest,
    loading: downloadDocumentFileLatestLoading,
  } = useApiRequestWrapper<
    (documendId: number) => Promise<AxiosResponse<ExternalResult<FileDownload>, any>>
  >({
    requestFunction: useCallback(
      async (mayanDocumentId: number) => await downloadDocumentFileLatestApiCall(mayanDocumentId),
      [downloadDocumentFileLatestApiCall],
    ),
    requestName: 'DownloadDocumentFileLatest',
    onSuccess: useCallback(() => toast.success('Download Downloaded Latest'), []),
    onError: useCallback((axiosError: AxiosError<IApiError>) => {
      if (axiosError?.response?.status === 400) {
        toast.error(axiosError?.response.data.error);
      } else {
        toast.error('Download document latest error. Check responses and try again.');
      }
    }, []),
  });

  return {
    retrieveDocumentMetadata,
    retrieveDocumentMetadataLoading,
    downloadDocumentFile,
    downloadDocumentFileLoading,
    downloadDocumentFileLatest,
    downloadDocumentFileLatestLoading,
  };
};
