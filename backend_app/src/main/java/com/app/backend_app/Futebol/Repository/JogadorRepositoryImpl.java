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
import com.app.backend_app.Futebol.Model.Jogador;
import com.app.backend_app.Futebol.Model.Time;

@Repository
public class JogadorRepositoryImpl implements JogadorRepository{
    
    private static String INSERT = " insert into tb_jogador (id, nome, datanascimento, nacionalidade, " 
            + " altura, posicao, gols, assistencias, imagem, time) "
            + " values (nextval('tb_jogador_id_seq'),?,?,?,?,?,?,?,?,?) ";
    private static String SELECT_ONE = " select * from tb_jogador where id = ?";
    private static String SELECT_ALL_TIME_COMPETICAO = " select tj.* from tb_jogador tj"
            + " inner join tb_time tt on tt.id = tj.time"
            + " inner join tb_classificacao tc on tc.time = tt.id"
            + " where tj.time = ? and tc.competicao = ?"
            + " order by nome, id";

    @Autowired
    private TimeRepository timeRepo;
            
    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public void setDataSource(DataSource dataSource){
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Jogador obterPorIdJogador(Integer id) {

        return jdbcTemplate.queryForObject(SELECT_ONE, new Object[] {id}, new RowMapper<Jogador>() {
            @Override
            public Jogador mapRow(ResultSet rs, int rownumber) throws SQLException {
                
                Jogador jogador = new Jogador();

                jogador.setId(rs.getInt("id"));
                jogador.setNome(rs.getString("nome"));
                jogador.setDataNascimento(rs.getString("datanascimento"));
                jogador.setNacionalidade(rs.getString("nacionalidade"));
                jogador.setAltura(rs.getDouble("altura"));
                jogador.setPosicao(rs.getString("posicao"));
                jogador.setGols(rs.getInt("gols"));
                jogador.setAssistencias(rs.getInt("assistencias"));
                jogador.setImagem(rs.getString("imagem"));

                Integer timeId = rs.getInt("time");
                Time time = timeRepo.obterPorIdTime(timeId);
                jogador.setTime(time);

                return jogador;
            }
        });

    }

    public List<Jogador> obterTodosJogadoresPorTimeCompeticao(Integer time, Integer competicao) {
        
        return jdbcTemplate.query(SELECT_ALL_TIME_COMPETICAO, new RowMapper<Jogador>() {
            @Override
            public Jogador mapRow(ResultSet rs, int rownumber) throws SQLException {

                Jogador jogador = new Jogador();

                jogador.setId(rs.getInt("id"));
                jogador.setNome(rs.getString("nome"));
                jogador.setDataNascimento(rs.getString("datanascimento"));
                jogador.setNacionalidade(rs.getString("nacionalidade"));
                jogador.setAltura(rs.getDouble("altura"));
                jogador.setPosicao(rs.getString("posicao"));
                jogador.setGols(rs.getInt("gols"));
                jogador.setAssistencias(rs.getInt("assistencias"));
                jogador.setImagem(rs.getString("imagem"));

                Integer timeId = rs.getInt("time");
                Time time = timeRepo.obterPorIdTime(timeId);
                jogador.setTime(time);

                return jogador;
            }
        }, time, competicao);

    }

    public Jogador salvarJogador(Jogador jogador) {
        
        KeyHolder holder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, jogador.getNome());
                ps.setString(2, jogador.getDataNascimento());
                ps.setString(3, jogador.getNacionalidade());
                ps.setDouble(4, jogador.getAltura());
                ps.setString(5, jogador.getPosicao());
                ps.setInt(6, jogador.getGols());
                ps.setInt(7, jogador.getAssistencias());
                ps.setString(8, jogador.getImagem());
                ps.setInt(9, jogador.getTime().getId());
                return ps;
            }
        }, holder);

        Integer id = (Integer) holder.getKeys().get("id");
        jogador.setId(id);
            
        return jogador;

    }
}

