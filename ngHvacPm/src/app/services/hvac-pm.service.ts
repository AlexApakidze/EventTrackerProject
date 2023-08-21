import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Observable, catchError, throwError } from 'rxjs';
import { HvacPm } from '../models/hvac-pm';

@Injectable({
  providedIn: 'root'
})
export class HvacPmService {
  private url = environment.baseUrl+"api/hvacpms";

  constructor(
    private http: HttpClient
  ) { }

  index(): Observable<HvacPm[]>  {
    return this.http.get<HvacPm[]>(this.url).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('index(): error retrieving pms: ' + err)
        );
      })
    );
  }

  create(pm: HvacPm): Observable<HvacPm> {

    return this.http.post<HvacPm>(this.url, pm).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('HvacPmService.create(): error creating pm: ' + err)
        );
      })
    );
  }

  update(updatedHvacPm: HvacPm): Observable<HvacPm> {
    return this.http.put<HvacPm>(this.url + "/" + updatedHvacPm.id, updatedHvacPm).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('HvacPmService.update(): error updating pm: ' + err)
        );
      })
    );
  }

  destroy(pmId: number): Observable<void> {
 // return this.http.delete<void>(this.url + "/" + pmId).pipe(
    return this.http.delete<void>(`${this.url}/${pmId}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError(
          () => new Error('HvacPmService.delete(): error deleting pm: ' + err)
        );
      })
    );
  }

}
