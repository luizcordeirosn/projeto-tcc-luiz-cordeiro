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
import com.app.backend_app.Futebol.Model.Penalti;
import com.app.backend_app.Futebol.Model.Time;

@Repository
public class PenaltiRepositoryImpl implements PenaltiRepository{
    
    private static String INSERT = " insert into tb_penalti (id, time, numpenaltis, cometido) "
            + " values (nextval('tb_penalti_id_seq'),?,?,?) ";
    private static String SELECT_ONE = " select * from tb_penalti where id = ?";
    private static String SELECT_ALL_COMPETICAO = " select tp.* from tb_penalti tp "
            + " inner join tb_time tt on tt.id = tp.time"
            + " inner join tb_classificacao tc on tc.time  = tt.id"
            + " where tc.competicao = ?"
            + " order by tp.cometido desc, tp.numpenaltis desc, tp.id";

    @Autowired
    private TimeRepository timeRepo;

    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public void setDataSource(DataSource dataSource){
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Penalti obterPorIdPenalti(Integer id) {

        return jdbcTemplate.queryForObject(SELECT_ONE, new Object[] {id}, new RowMapper<Penalti>() {
            @Override
            public Penalti mapRow(ResultSet rs, int rownumber) throws SQLException {
                
                Penalti penalti = new Penalti();

                penalti.setId(rs.getInt("id"));
                
                Integer timeId = rs.getInt("time");
                Time time = timeRepo.obterPorIdTime(timeId);
                penalti.setTime(time);

                penalti.setNumPenaltis(rs.getInt("numpenaltis"));
                penalti.setCometido(rs.getBoolean("cometido"));

                return penalti;
            }
        });

    }

    public List<Penalti> obterTodosPenaltisPorCompeticao(Integer competicao) {
        
        return jdbcTemplate.query(SELECT_ALL_COMPETICAO, new RowMapper<Penalti>() {
            @Override
            public Penalti mapRow(ResultSet rs, int rownumber) throws SQLException {

                Penalti penalti = new Penalti();

                penalti.setId(rs.getInt("id"));
                
                Integer timeId = rs.getInt("time");
                Time time = timeRepo.obterPorIdTime(timeId);
                penalti.setTime(time);

                penalti.setNumPenaltis(rs.getInt("numpenaltis"));
                penalti.setCometido(rs.getBoolean("cometido"));

                return penalti;
            }
        }, competicao);

    }

    public Penalti salvarPenalti(Penalti penalti) {
        
        KeyHolder holder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, penalti.getTime().getId());
                ps.setInt(2, penalti.getNumPenaltis());
                ps.setBoolean(3, penalti.isCometido());
                return ps;
            }
        }, holder);

        Integer id = (Integer) holder.getKeys().get("id");
        penalti.setId(id);
            
        return penalti;

    }
}

