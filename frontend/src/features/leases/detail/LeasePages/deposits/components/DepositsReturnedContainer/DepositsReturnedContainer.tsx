import { FormSection } from 'components/common/form/styles';
import { Table } from 'components/Table';
import { Api_SecurityDeposit, Api_SecurityDepositReturn } from 'models/api/SecurityDeposit';

import * as Styled from '../../styles';
import { getColumns, ReturnListEntry } from './columns';

export interface IDepositsReturnedContainerProps {
  securityDeposits: Api_SecurityDeposit[];
  depositReturns: Api_SecurityDepositReturn[];
  onEdit: (id: number) => void;
  onDelete: (id: number) => void;
}

const DepositsReturnedContainer: React.FC<IDepositsReturnedContainerProps> = ({
  securityDeposits,
  depositReturns,
  onEdit,
  onDelete,
}) => {
  const columns = getColumns({ onEdit, onDelete });
  const dataSource = depositReturns.reduce(
    (accumulator: ReturnListEntry[], returnDeposit: Api_SecurityDepositReturn) => {
      var parentDeposit = securityDeposits.find(r => r.id === returnDeposit.parentDepositId);
      if (parentDeposit) {
        accumulator.push(new ReturnListEntry(returnDeposit, parentDeposit));
      }
      return accumulator;
    },
    [],
  );
  return (
    <FormSection>
      <Styled.SectionHeader>Deposits Returned</Styled.SectionHeader>

      <Table<ReturnListEntry>
        name="securityDepositReturnsTable"
        columns={columns}
        data={dataSource}
        manualPagination={true}
        hideToolbar={true}
        noRowsMessage="There is no corresponding data"
      />
    </FormSection>
  );
};

export default DepositsReturnedContainer;
