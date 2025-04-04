package com.project.repository;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;

import com.project.model.BoardDto;

@Mapper
public interface BoardMapper {
    public int getCount();
    public List<BoardDto> getArticles(Map<String, Integer> map);
    public BoardDto getArticle(int board_id);
    public void addCount(int board_id);
}