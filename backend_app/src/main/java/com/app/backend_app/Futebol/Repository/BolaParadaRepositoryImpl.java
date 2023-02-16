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
import com.app.backend_app.Futebol.Model.BolaParada;
import com.app.backend_app.Futebol.Model.Jogador;

@Repository
public class BolaParadaRepositoryImpl implements BolaParadaRepository {

    private static String INSERT = " insert into tb_bolaparada (id, jogador, tipo) "
            + " values (nextval('tb_bolaparada_id_seq'),?,?) ";
    private static String SELECT_ONE = " select * from tb_bolaparada where id = ?";
    private static String SELECT_ALL_FALTA_TIME_COMPETICAO = " select tbp.* from tb_bolaparada tbp"
            + " inner join tb_jogador tj on tj.id = tbp.jogador"
            + " inner join tb_time tt on tt.id = tj.time"
            + " inner join tb_classificacao tc on tc.time = tt.id"
            + " where tbp.tipo = 'Falta' and tj.time = ? and tc.competicao = ?"
            + " order by tj.nome, tbp.id";
    private static String SELECT_ALL_ESCANTEIO_TIME_COMPETICAO = " select tbp.* from tb_bolaparada tbp"
            + " inner join tb_jogador tj on tj.id = tbp.jogador"
            + " inner join tb_time tt on tt.id = tj.time"
            + " inner join tb_classificacao tc on tc.time = tt.id"
            + " where tbp.tipo = 'Escanteio' and tj.time = ? and tc.competicao = ?"
            + " order by tj.nome, tbp.id";
    private static String SELECT_ALL_PENALTI_TIME_COMPETICAO = " select tbp.* from tb_bolaparada tbp"
            + " inner join tb_jogador tj on tj.id = tbp.jogador"
            + " inner join tb_time tt on tt.id = tj.time"
            + " inner join tb_classificacao tc on tc.time = tt.id"
            + " where tbp.tipo = 'Pênalti' and tj.time = ? and tc.competicao = ?"
            + " order by tj.nome, tbp.id";

    @Autowired
    private JogadorRepository jogadorRepo;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public BolaParada obterPorIdBolaParada(Integer id) {

        return jdbcTemplate.queryForObject(SELECT_ONE, new Object[] { id }, new RowMapper<BolaParada>() {
            @Override
            public BolaParada mapRow(ResultSet rs, int rownumber) throws SQLException {

                BolaParada bolaParada = new BolaParada();

                bolaParada.setId(rs.getInt("id"));

                Integer jogadorId = rs.getInt("jogador");
                Jogador jogador = jogadorRepo.obterPorIdJogador(jogadorId);
                bolaParada.setJogador(jogador);

                bolaParada.setTipo(rs.getString("tipo"));

                return bolaParada;
            }
        });

    }

    public List<BolaParada> obterTodosBolaParadaFaltasPorTimeCompeticao(Integer time, Integer competicao) {

        return jdbcTemplate.query(SELECT_ALL_FALTA_TIME_COMPETICAO, new RowMapper<BolaParada>() {
            @Override
            public BolaParada mapRow(ResultSet rs, int rownumber) throws SQLException {

                BolaParada bolaParada = new BolaParada();

                bolaParada.setId(rs.getInt("id"));

                Integer jogadorId = rs.getInt("jogador");
                Jogador jogador = jogadorRepo.obterPorIdJogador(jogadorId);
                bolaParada.setJogador(jogador);

                bolaParada.setTipo(rs.getString("tipo"));

                return bolaParada;
            }
        }, time, competicao);

    }

    public List<BolaParada> obterTodosBolaParadaEscanteiosPorTimeCompeticao(Integer time, Integer competicao) {

        return jdbcTemplate.query(SELECT_ALL_ESCANTEIO_TIME_COMPETICAO, new RowMapper<BolaParada>() {
            @Override
            public BolaParada mapRow(ResultSet rs, int rownumber) throws SQLException {

                BolaParada bolaParada = new BolaParada();

                bolaParada.setId(rs.getInt("id"));

                Integer jogadorId = rs.getInt("jogador");
                Jogador jogador = jogadorRepo.obterPorIdJogador(jogadorId);
                bolaParada.setJogador(jogador);

                bolaParada.setTipo(rs.getString("tipo"));

                return bolaParada;
            }
        }, time, competicao);

    }

    public List<BolaParada> obterTodosBolaParadaPenaltisPorTimeCompeticao(Integer time, Integer competicao) {

        return jdbcTemplate.query(SELECT_ALL_PENALTI_TIME_COMPETICAO, new RowMapper<BolaParada>() {
            @Override
            public BolaParada mapRow(ResultSet rs, int rownumber) throws SQLException {

                BolaParada bolaParada = new BolaParada();

                bolaParada.setId(rs.getInt("id"));

                Integer jogadorId = rs.getInt("jogador");
                Jogador jogador = jogadorRepo.obterPorIdJogador(jogadorId);
                bolaParada.setJogador(jogador);

                bolaParada.setTipo(rs.getString("tipo"));

                return bolaParada;
            }
        }, time, competicao);

    }

    public BolaParada salvarBolaParada(BolaParada bolaParada) {

        KeyHolder holder = new GeneratedKeyHolder();

        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, bolaParada.getJogador().getId());
                ps.setString(2, bolaParada.getTipo());
                return ps;
            }
        }, holder);

        Integer id = (Integer) holder.getKeys().get("id");
        bolaParada.setId(id);

        return bolaParada;

    }
}
