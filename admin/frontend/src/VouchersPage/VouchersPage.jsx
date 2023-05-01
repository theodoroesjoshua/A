
import axios from "axios";
import React from "react";
import { withRouter } from '../_helpers';
import { authHeader } from "../_helpers/auth-Header";
import { Link } from "react-router-dom";
import styled from 'styled-components';

class VouchersPageComponent extends React.Component  {

    // Set the vouchers as state.
    constructor(props) {
        super(props);
        this.deleteVoucher = this.deleteVoucher.bind(this);
        this.state = { vouchers: [] };
    }

    // Retrieve data from database upon mounting the element and put the values into the state.
    componentDidMount() {
        axios.get(process.env.REACT_APP_BACKEND_URL + '/api/v1/vouchers?limit=10&offset=0', authHeader())
        .then((response) => {
            this.setState({ vouchers: response.data });
        }).catch((error) => console.log(error));
    }

  // This method will delete a voucher based on the method
  // TODO: Backend function to delete voucher.
  deleteVoucher(code) {
    if (!window.confirm("Apakah anda yakin ingin menghapus voucher?")) {
      return
    }

    axios
        .post(process.env.REACT_APP_BACKEND_URL + "/api/v1/voucher/" + code + "/delete", {} , authHeader())
        .then((response) => {
          console.log(response.data);

          // Update local state
          this.setState({
            vouchers: this.state.vouchers.filter((x) => x.code !== code),
          });
        });
  }

    createVouchersTable() {        
        return this.state.vouchers.map((currentVoucher) => {
            return (
                 <VoucherRow
                    voucher = {currentVoucher}
                    deleteVoucher = {this.deleteVoucher}
                    key = {currentVoucher.code}
                />
            );
        });
    }

    // TODO: Link to creating new voucher.
    render() {
        return (
            <div>                
                <center>
                    <h3>Vouchers List</h3>
                    <BtnLink to={"/admin/voucher/create"}>Buat Voucher Baru</BtnLink>
                </center>

                <table className="table table-striped" style={{ marginTop: 20 }}>
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Issue Date</th>
                            <th>Expiry Date</th>
                            <th>Claimed Date</th>
                            <th>Status</th>
                            <th>Customer ID</th>
                            <th>Issue Receipt ID</th>
                            <th>Issue Receipt Price</th>
                            <th>Issue Admin ID</th>
                            <th>Issue Date</th>
                        </tr>
                    </thead>
                    <tbody>{this.createVouchersTable()}</tbody>
                </table>
            </div>
        );
    }
}

// TODO: Link to the voucher's detail for editing purposes.
const VoucherRow = (props) => {
    const deleteVoucher = () => props.deleteVoucher(props.voucher.code);
    console.log(props);
    return (
        <tr>
            <td>{props.voucher.code}</td>
            <td>{props.voucher.start_date}</td>
            <td>{props.voucher.end_date}</td>
            <td>{props.voucher.claimed_date}</td>
            <td>{props.voucher.status}</td>
            <td>{props.voucher.customer_id}</td>
            <td>{props.voucher.issue_receipt_id}</td>
            <td>{props.voucher.issuer_price}</td>
            <td>{props.voucher.issuer_admin_id}</td>
            <td>{props.voucher.issue_date}</td>
            <td>
                <Link to={"/admin/vouchers/view/" + props.voucher.code}>Edit</Link> |
                <Link to="#" onClick={deleteVoucher}>Hapus</Link>
            </td>
        </tr>
    )
}

export const BtnLink = styled(Link)`
  border-radius: 4px;
  background: #ADD8E6;
  padding: 10px 22px;
  color: #000000;
  outline: none;
  border: none;
  cursor: pointer;
  transition: all 0.2s ease-in-out;
  font-size: 1.5rem;
  text-decoration: none;
  &:hover {
    transition: all 0.2s ease-in-out;
    background: #B0E0E6;
    color: #808080;
  }
`;

export const VouchersPage = withRouter(VouchersPageComponent);