package com.skilldistillery.hvacpm.services;

import java.util.List;

import com.skilldistillery.hvacpm.entities.HvacPm;

public interface HvacPmService {

	List<HvacPm> listAllPms();

	HvacPm getPm(int pmId);

	HvacPm create(HvacPm pm);

	HvacPm update(int pmId, HvacPm pm);

	boolean delete(int pmId);

}
