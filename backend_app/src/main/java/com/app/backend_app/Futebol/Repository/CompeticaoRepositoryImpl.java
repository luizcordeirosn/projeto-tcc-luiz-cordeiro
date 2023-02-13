package com.app.backend_app.Futebol.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.app.backend_app.Futebol.Model.Competicao;

@Repository
public class CompeticaoRepositoryImpl implements CompeticaoRepository{
    
    private static String INSERT = " insert into tb_competicao (id, titulo) "
            + " values (nextval('tb_competicao_id_seq'),?) ";
    private static String SELECT_ONE = " select * from tb_competicao where id = ?";

    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public void setDataSource(DataSource dataSource){
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Competicao obterPorIdCompeticao(Integer id) {

        return jdbcTemplate.queryForObject(SELECT_ONE, new Object[] {id}, new RowMapper<Competicao>() {
            @Override
            public Competicao mapRow(ResultSet rs, int rownumber) throws SQLException {
                
                Competicao competicao = new Competicao();

                competicao.setId(rs.getInt("id"));
                competicao.setTitulo(rs.getString("titulo"));

                return competicao;
            }
        });

    }

    public Competicao salvarCompeticao(Competicao competicao) {
        
        KeyHolder holder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, competicao.getTitulo());
                return ps;
            }
        }, holder);

        Integer id = (Integer) holder.getKeys().get("id");
        competicao.setId(id);
            
        return competicao;

    }
}

