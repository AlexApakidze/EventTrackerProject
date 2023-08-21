export class HvacPm {
  id: number;
  quarter: number;
  address: string;
  customer: string;
  tasks: string;
  techs: string;
  contacts: string;
  units: string;
  completed: boolean;

  constructor(
    id: number =0,
    quarter: number =0,
    address: string='',
    customer: string='',
    tasks: string='',
    techs: string='',
    contacts: string='',
    units: string='',
    completed: boolean= false
  ){
    this.id = id;
    this.quarter = quarter;
    this.address = address
    this.customer = customer
    this.tasks = tasks
    this.techs = techs
    this.contacts=contacts
    this.units=units
    this.completed=completed
  }
}
