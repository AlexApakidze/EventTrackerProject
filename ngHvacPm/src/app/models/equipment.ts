export class Equipment {
  id: number;
  make:string;
  model: string;
  serial: string;


  constructor(
    id: number =0,
    make:string='',
    model: string='',
    serial: string=''

  ){
    this.id = id;
    this.make=make;
    this.model=model;
    this.serial=serial;

  }
}
