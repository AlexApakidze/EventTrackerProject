package com.skilldistillery.hvacpm.services;

import java.util.List;
import java.util.Optional;

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
	public HvacPm getById(int pmId) {
		Optional<HvacPm> pmOpt = pmRepo.findById(pmId);
		if (pmOpt.isPresent()) {
			return pmOpt.get();
		}
		return null;
	}

	@Override
	public HvacPm create(HvacPm newHvacPm) {

		return pmRepo.saveAndFlush(newHvacPm);
	}

	@Override
	public HvacPm update(int pmId, HvacPm newHvacPm) {
		HvacPm existingHvacPm = null;
		Optional<HvacPm> existingOpt = pmRepo.findById(pmId);
		if (existingOpt.isPresent()) {
			existingHvacPm = existingOpt.get();
			existingHvacPm.setAddress(newHvacPm.getAddress());
			existingHvacPm.setContacts(newHvacPm.getContacts());
			existingHvacPm.setCustomer(newHvacPm.getCustomer());
			existingHvacPm.setQuarter(newHvacPm.getQuarter());
			existingHvacPm.setTasks(newHvacPm.getTasks());
			existingHvacPm.setTechs(newHvacPm.getTechs());
			existingHvacPm.setUnits(newHvacPm.getUnits());
			pmRepo.saveAndFlush(existingHvacPm);
		}
		return existingHvacPm;
	}

	@Override
	public boolean delete(int pmId) {
		boolean deleted = false;
		Optional<HvacPm> toDeleteOpt = pmRepo.findById(pmId);
		if (toDeleteOpt.isPresent()) {
			pmRepo.delete(toDeleteOpt.get());
			deleted = true;
		}

		return deleted;
	}

}
