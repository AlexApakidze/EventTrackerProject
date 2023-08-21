export class Task {
  id: number;
  todo:string;


  constructor(
    id: number =0,
    todo:string=''

  ){
    this.id = id;
    this.todo=todo;

  }
}
