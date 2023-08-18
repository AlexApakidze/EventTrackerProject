import { TestBed } from '@angular/core/testing';

import { HvacPmService } from './hvac-pm.service';

describe('HvacPmService', () => {
  let service: HvacPmService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HvacPmService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
