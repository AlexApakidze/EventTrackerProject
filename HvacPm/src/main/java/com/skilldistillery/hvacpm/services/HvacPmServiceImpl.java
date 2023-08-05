package com.skilldistillery.hvacpm.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.hvacpm.entities.HvacPm;
import com.skilldistillery.hvacpm.repositories.HvacPmRepository;

@Service
public class HvacPmServiceImpl implements HvacPmService {

	
	@Autowired
	private HvacPmRepository pmRepo;
	
	@Override
	public List<HvacPm> listAllPms() {
		return pmRepo.findAll();
	}

	@Override
	public HvacPm getPm(int pmId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public HvacPm create(HvacPm pm) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public HvacPm update(int pmId, HvacPm pm) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean delete(int pmId) {
		// TODO Auto-generated method stub
		return false;
	}

}
