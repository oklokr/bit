package com.project.repository;

import org.apache.ibatis.annotations.Mapper;

import com.project.model.BoardDto;

@Mapper
public interface BoardMapper {
    public int getCount();
    public int addBoard(BoardDto boardDto);
    public int modifyBoard(BoardDto boardDto);
    public int deleteBoard(BoardDto boardDto);
}
