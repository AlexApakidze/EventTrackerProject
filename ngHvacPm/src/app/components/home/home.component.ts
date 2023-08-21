import { HvacPm } from 'src/app/models/hvac-pm';
import { HvacPmService } from './../../services/hvac-pm.service';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit{
title ="HVAC PM"

pmList: HvacPm[] =[]
selected: HvacPm | null = null;
newHvacPm: HvacPm = new HvacPm();
editHvacPm: HvacPm | null = null;

  constructor(
    private pmService: HvacPmService
  ){}

  ngOnInit(): void {
    this.reload();
  }

reload(){
this.pmService.index().subscribe({
  next: (list)=> {
    this.pmList = list;
  },
  error: (fail) =>{
    console.error('error')
  }
})
}


getHvacPmCount(): number {
  return this.pmList.length;
}

displayHvacPm(pm: HvacPm): void {
  this.selected = pm;
}

displayTable(): void {
  this.selected = null;
}

addHvacPm(pm: HvacPm): void {
  this.pmService.create(pm).subscribe( {
    next: (createdHvacPm) => {
      this.newHvacPm = new HvacPm();
      this.reload();
    },
    error: (fail) => {
      console.error('HvacPmComponent.addHvacPm: error creating pm');
      console.error(fail);
    }
  } );
}

setEditHvacPm() {
  this.editHvacPm = Object.assign({}, this.selected);
}

updateHvacPm(pm: HvacPm, setSelected: boolean = true) {
  this.pmService.update(pm).subscribe( {
    next: (updatedHvacPm) => {
      if (setSelected) {
        this.selected = updatedHvacPm;
      }
      this.editHvacPm = null;
      this.reload();
    },
    error: (oops: any) => {
      console.error('HvacPmComponent.updateHvacPm: error on update');
      console.error(oops);
    }
  } );
}

deleteHvacPm(pmId: number) {
  this.pmService.destroy(pmId).subscribe( {
    next: () => {
      this.reload();
    },
    error: (toobad) => {
      console.error('HvacPmComponent.deleteHvacPm: error on delete');
      console.error(toobad);
    }
  } );
}


}
