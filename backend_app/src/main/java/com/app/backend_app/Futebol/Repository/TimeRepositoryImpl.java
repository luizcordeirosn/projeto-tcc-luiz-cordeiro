package com.app.backend_app.Futebol.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import com.app.backend_app.Futebol.Model.Competicao;
import com.app.backend_app.Futebol.Model.Time;

@Repository
public class TimeRepositoryImpl implements TimeRepository{
    
    private static String INSERT = " insert into tb_time (id, titulo) "
            + " values (nextval('tb_time_id_seq'),?) ";
    private static String INSERT_TIME_COMPETICAO = " insert into tb_time_competicao (timeid, competicaoid) "
            + " values (?,?) ";
    private static String SELECT_ONE = " select * from tb_time where id = ?";
    private static String SELECT_ALL_COMPETICAO = " select tt.* from tb_time tt"
            + " inner join tb_time_competicao ttc on ttc.timeid = tt.id"
            + " inner join tb_competicao tc on tc.id = ttc.competicaoid"
            + " where tc.id = ?";

    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public void setDataSource(DataSource dataSource){
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Time obterPorIdTime(Integer id) {

        return jdbcTemplate.queryForObject(SELECT_ONE, new Object[] {id}, new RowMapper<Time>() {
            @Override
            public Time mapRow(ResultSet rs, int rownumber) throws SQLException {
                
                Time time = new Time();

                time.setId(rs.getInt("id"));
                time.setTitulo(rs.getString("titulo"));

                return time;
            }
        });

    }

    public List<Time> obterTodosTimesPorCompeticao(Integer competicao) {
        
        return jdbcTemplate.query(SELECT_ALL_COMPETICAO, new RowMapper<Time>() {
            @Override
            public Time mapRow(ResultSet rs, int rownumber) throws SQLException {

                Time time = new Time();

                time.setId(rs.getInt("id"));
                time.setTitulo(rs.getString("titulo"));

                return time;
            }
        }, competicao);

    }

    public Time salvarTime(Time time) {
        
        KeyHolder holder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, time.getTitulo());
                return ps;
            }
        }, holder);

        Integer id = (Integer) holder.getKeys().get("id");
        time.setId(id);
            
        return time;

    }

    public Time salvarTimePorCompeticao(Time time, Competicao competicao) {
        
        KeyHolder holder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT_TIME_COMPETICAO, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, time.getId());
                ps.setInt(2, competicao.getId());
                return ps;
            }
        }, holder);
            
        return time;

    }
}
