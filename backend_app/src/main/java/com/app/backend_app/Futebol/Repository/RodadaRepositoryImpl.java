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
import com.app.backend_app.Futebol.Model.Rodada;

@Repository
public class RodadaRepositoryImpl implements RodadaRepository{
    
    private static String INSERT = " insert into tb_rodada (id, titulo, competicao) "
            + " values (nextval('tb_rodada_id_seq'),?,?) ";
    private static String SELECT_ONE = " select * from tb_rodada where id = ?";
    private static String SELECT_ALL_COMPETICAO = " select * from tb_rodada where competicao = ?"
            + " order by titulo, id";

    @Autowired
    private CompeticaoRepository competicaoRepo;

    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public void setDataSource(DataSource dataSource){
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Rodada obterPorIdRodada(Integer id) {

        return jdbcTemplate.queryForObject(SELECT_ONE, new Object[] {id}, new RowMapper<Rodada>() {
            @Override
            public Rodada mapRow(ResultSet rs, int rownumber) throws SQLException {
                
                Rodada rodada = new Rodada();

                rodada.setId(rs.getInt("id"));
                rodada.setTitulo(rs.getString("titulo"));
                
                Integer competicaoId = rs.getInt("competicao");
                Competicao competicao = competicaoRepo.obterPorIdCompeticao(competicaoId);
                rodada.setCompeticao(competicao);

                return rodada;
            }
        });

    }

    public List<Rodada> obterTodosRodadasPorCompeticao(Integer competicao) {
        
        return jdbcTemplate.query(SELECT_ALL_COMPETICAO, new RowMapper<Rodada>() {
            @Override
            public Rodada mapRow(ResultSet rs, int rownumber) throws SQLException {

                Rodada rodada = new Rodada();

                rodada.setId(rs.getInt("id"));
                rodada.setTitulo(rs.getString("titulo"));
                
                Integer competicaoId = rs.getInt("competicao");
                Competicao competicao = competicaoRepo.obterPorIdCompeticao(competicaoId);
                rodada.setCompeticao(competicao);

                return rodada;
            }
        }, competicao);

    }

    public Rodada salvarRodada(Rodada rodada) {
        
        KeyHolder holder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, rodada.getTitulo());
                ps.setInt(2, rodada.getCompeticao().getId());
                return ps;
            }
        }, holder);

        Integer id = (Integer) holder.getKeys().get("id");
        rodada.setId(id);
            
        return rodada;

    }
}
