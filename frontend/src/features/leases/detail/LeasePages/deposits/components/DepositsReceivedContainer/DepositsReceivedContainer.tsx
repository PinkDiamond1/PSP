import { Button } from 'components/common/buttons/Button';
import { FormSection } from 'components/common/form/styles';
import { Table } from 'components/Table';
import Claims from 'constants/claims';
import useKeycloakWrapper from 'hooks/useKeycloakWrapper';
import { Api_SecurityDeposit } from 'models/api/SecurityDeposit';

import * as Styled from '../../styles';
import { DepositListEntry, getColumns } from './columns';

export interface IDepositsReceivedContainerProps {
  securityDeposits: Api_SecurityDeposit[];
  onAdd: () => void;
  onEdit: (id: number) => void;
  onDelete: (id: number) => void;
  onReturn: (id: number) => void;
}

const DepositsReceivedContainer: React.FC<IDepositsReceivedContainerProps> = ({
  securityDeposits,
  onAdd,
  onEdit,
  onDelete,
  onReturn,
}) => {
  const { hasClaim } = useKeycloakWrapper();
  const columns = getColumns({ onEdit, onDelete, onReturn });
  const dataSource = securityDeposits.map<DepositListEntry>(d => {
    return new DepositListEntry(d);
  });
  return (
    <FormSection>
      <Styled.SectionHeader>Deposits Received</Styled.SectionHeader>
      <Button
        variant="secondary"
        onClick={() => onAdd()}
        className="mb-4 px-5"
        disabled={!hasClaim(Claims.LEASE_ADD)}
      >
        Add a deposit
      </Button>
      <Table<DepositListEntry>
        name="securityDepositsTable"
        columns={columns}
        data={dataSource}
        manualPagination={true}
        hideToolbar={true}
        noRowsMessage="There is no corresponding data"
      />
    </FormSection>
  );
};

export default DepositsReceivedContainer;
