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
import com.app.backend_app.Futebol.Model.Confronto;
import com.app.backend_app.Futebol.Model.Rodada;
import com.app.backend_app.Futebol.Model.Time;

@Repository
public class ConfrontoRepositoryImpl implements ConfrontoRepository{
    
    private static String INSERT = " insert into tb_confronto (id, rodada, timemandante, timevisitante, " 
            + " datahora, resultado) "
            + " values (nextval('tb_confronto_id_seq'),?,?,?,?,?) ";
    private static String SELECT_ONE = " select * from tb_confronto where id = ?";
    private static String SELECT_ALL_COMPETICAO = " select * from tb_confronto where rodada = ?"
            + " order by datahora, id";

    @Autowired
    private TimeRepository timeRepo;
            
    @Autowired
    private RodadaRepository rodadaRepo;

    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public void setDataSource(DataSource dataSource){
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Confronto obterPorIdConfronto(Integer id) {

        return jdbcTemplate.queryForObject(SELECT_ONE, new Object[] {id}, new RowMapper<Confronto>() {
            @Override
            public Confronto mapRow(ResultSet rs, int rownumber) throws SQLException {
                
                Confronto confronto = new Confronto();

                confronto.setId(rs.getInt("id"));

                Integer competicaoId = rs.getInt("rodada");
                Rodada rodada = rodadaRepo.obterPorIdRodada(competicaoId);
                confronto.setRodada(rodada);
                
                Integer timeMandanteId = rs.getInt("timemandante");
                Time timeMandante = timeRepo.obterPorIdTime(timeMandanteId);
                confronto.setTimeMandante(timeMandante);

                Integer timeVisitanteId = rs.getInt("timevisitante");
                Time timeVisitante = timeRepo.obterPorIdTime(timeVisitanteId);
                confronto.setTimeVisitante(timeVisitante);

                confronto.setDataHora(rs.getString("datahora"));
                confronto.setResultado(rs.getString("resultado"));

                return confronto;
            }
        });

    }

    public List<Confronto> obterTodosConfrontosPorRodada(Integer rodada) {
        
        return jdbcTemplate.query(SELECT_ALL_COMPETICAO, new RowMapper<Confronto>() {
            @Override
            public Confronto mapRow(ResultSet rs, int rownumber) throws SQLException {

                Confronto confronto = new Confronto();

                confronto.setId(rs.getInt("id"));

                Integer competicaoId = rs.getInt("rodada");
                Rodada rodada = rodadaRepo.obterPorIdRodada(competicaoId);
                confronto.setRodada(rodada);
                
                Integer timeMandanteId = rs.getInt("timemandante");
                Time timeMandante = timeRepo.obterPorIdTime(timeMandanteId);
                confronto.setTimeMandante(timeMandante);

                Integer timeVisitanteId = rs.getInt("timevisitante");
                Time timeVisitante = timeRepo.obterPorIdTime(timeVisitanteId);
                confronto.setTimeVisitante(timeVisitante);

                confronto.setDataHora(rs.getString("datahora"));
                confronto.setResultado(rs.getString("resultado"));

                return confronto;
            }
        }, rodada);

    }

    public Confronto salvarConfronto(Confronto confronto) {
        
        KeyHolder holder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, confronto.getRodada().getId());
                ps.setInt(2, confronto.getTimeMandante().getId());
                ps.setInt(3, confronto.getTimeVisitante().getId());
                ps.setString(4, confronto.getDataHora());
                ps.setString(5, confronto.getResultado());
                return ps;
            }
        }, holder);

        Integer id = (Integer) holder.getKeys().get("id");
        confronto.setId(id);
            
        return confronto;

    }
}

