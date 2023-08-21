import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { Observable, catchError, throwError } from 'rxjs';
import { Technician} from '../models/technician';

@Injectable({
  providedIn: 'root'
})
export class TechnicianService {



	private url = environment.baseUrl+"api/hvactechs";

	  constructor(
	    private http: HttpClient
	  ) { }

	  index(): Observable<Technician[]>  {
	    return this.http.get<Technician[]>(this.url).pipe(
	      catchError((err: any) => {
	        console.log(err);
	        return throwError(
	          () => new Error('index(): error retrieving techs: ' + err)
	        );
	      })
	    );
	  }

	  create(tech: Technician): Observable<Technician> {

	    return this.http.post<Technician>(this.url, tech).pipe(
	      catchError((err: any) => {
	        console.log(err);
	        return throwError(
	          () => new Error('TechnicianService.create(): error creating tech: ' + err)
	        );
	      })
	    );
	  }

	  update(updatedTechnician: Technician): Observable<Technician> {
	    return this.http.put<Technician>(this.url + "/" + updatedTechnician.id, updatedTechnician).pipe(
	      catchError((err: any) => {
	        console.log(err);
	        return throwError(
	          () => new Error('TechnicianService.update(): error updating tech: ' + err)
	        );
	      })
	    );
	  }

	  destroy(techId: number): Observable<void> {
	 // return this.http.delete<void>(this.url + "/" + techId).pipe(
	    return this.http.delete<void>(`${this.url}/${techId}`).pipe(
	      catchError((err: any) => {
	        console.log(err);
	        return throwError(
	          () => new Error('TechnicianService.delete(): error deleting tech: ' + err)
	        );
	      })
	    );
	  }

	}

