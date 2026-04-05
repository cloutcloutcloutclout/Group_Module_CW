package com.example.group52.repository;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.data.repository.CrudRepository;

import com.example.group52.model.Course;

public interface CourseRepository extends CrudRepository<Course, Integer> {
    List<Course> findByNameContainingIgnoreCase(String name, Sort sort); //repository method to find and filter courses
    List<Course> findAll(Sort sort); //repository method to find and filter courses
    List<Course> findAll(); //repository method to find and filter courses
    List<Course> findTop3ByOrderByEnrollmentCountDesc();

}
