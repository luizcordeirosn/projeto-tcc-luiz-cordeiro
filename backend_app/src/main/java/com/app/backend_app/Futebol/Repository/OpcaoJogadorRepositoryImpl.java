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
import com.app.backend_app.Futebol.Model.OpcaoJogador;
import com.app.backend_app.Futebol.Model.Jogador;
import com.app.backend_app.Futebol.Model.Rodada;

@Repository
public class OpcaoJogadorRepositoryImpl implements OpcaoJogadorRepository{
    
    private static String INSERT = " insert into tb_opcaojogador (id, jogador, rodada, boapontuacao, " 
            + " posicao) "
            + " values (nextval('tb_opcaojogador_id_seq'),?,?,?,?) ";
    private static String SELECT_ONE = " select * from tb_opcaojogador where id = ?";
    private static String SELECT_ALL_RODADA_COMPETICAO = " select toj.* from tb_opcaojogador toj"
            + " inner join tb_rodada tr on tr.id = toj.rodada"
            + " where toj.rodada = ? and tr.competicao = ?"
            + " order by toj.boapontuacao desc, toj.id";
    private static String SELECT_ALL_POSICAO_RODADA_COMPETICAO = " select toj.* from tb_opcaojogador toj"
            + " inner join tb_rodada tr on tr.id = toj.rodada"
            + " where toj.rodada = ? and tr.competicao = ? and toj.posicao = ?"
            + " order by toj.boapontuacao desc, toj.id";

    @Autowired
    private JogadorRepository jogadorRepo;
            
    @Autowired
    private RodadaRepository rodadaRepo;

    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public void setDataSource(DataSource dataSource){
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public OpcaoJogador obterPorIdOpcaoJogador(Integer id) {

        return jdbcTemplate.queryForObject(SELECT_ONE, new Object[] {id}, new RowMapper<OpcaoJogador>() {
            @Override
            public OpcaoJogador mapRow(ResultSet rs, int rownumber) throws SQLException {
                
                OpcaoJogador opcaoJogador = new OpcaoJogador();

                opcaoJogador.setId(rs.getInt("id"));

                Integer jogadorId = rs.getInt("jogador");
                Jogador jogador = jogadorRepo.obterPorIdJogador(jogadorId);
                opcaoJogador.setJogador(jogador);

                Integer competicaoId = rs.getInt("rodada");
                Rodada rodada = rodadaRepo.obterPorIdRodada(competicaoId);
                opcaoJogador.setRodada(rodada);
                
                opcaoJogador.setBoaPontuacao(rs.getInt("boapontuacao"));
                opcaoJogador.setPosicao(rs.getString("posicao"));

                return opcaoJogador;
            }
        });

    }

    public List<OpcaoJogador> obterTodosOpcoesJogadorPorRodadaCampeonato(Integer rodada, Integer competicao) {
        
        return jdbcTemplate.query(SELECT_ALL_RODADA_COMPETICAO, new RowMapper<OpcaoJogador>() {
            @Override
            public OpcaoJogador mapRow(ResultSet rs, int rownumber) throws SQLException {

                OpcaoJogador opcaoJogador = new OpcaoJogador();

                opcaoJogador.setId(rs.getInt("id"));

                Integer jogadorId = rs.getInt("jogador");
                Jogador jogador = jogadorRepo.obterPorIdJogador(jogadorId);
                opcaoJogador.setJogador(jogador);

                Integer competicaoId = rs.getInt("rodada");
                Rodada rodada = rodadaRepo.obterPorIdRodada(competicaoId);
                opcaoJogador.setRodada(rodada);
                
                opcaoJogador.setBoaPontuacao(rs.getInt("boapontuacao"));
                opcaoJogador.setPosicao(rs.getString("posicao"));

                return opcaoJogador;
            }
        }, rodada, competicao);

    }

    public List<OpcaoJogador> obterTodosOpcoesJogadorPosicaoPorRodadaCampeonato(Integer rodada, Integer competicao, String posicao) {
        
        return jdbcTemplate.query(SELECT_ALL_POSICAO_RODADA_COMPETICAO, new RowMapper<OpcaoJogador>() {
            @Override
            public OpcaoJogador mapRow(ResultSet rs, int rownumber) throws SQLException {

                OpcaoJogador opcaoJogador = new OpcaoJogador();

                opcaoJogador.setId(rs.getInt("id"));

                Integer jogadorId = rs.getInt("jogador");
                Jogador jogador = jogadorRepo.obterPorIdJogador(jogadorId);
                opcaoJogador.setJogador(jogador);

                Integer competicaoId = rs.getInt("rodada");
                Rodada rodada = rodadaRepo.obterPorIdRodada(competicaoId);
                opcaoJogador.setRodada(rodada);
                
                opcaoJogador.setBoaPontuacao(rs.getInt("boapontuacao"));
                opcaoJogador.setPosicao(rs.getString("posicao"));

                return opcaoJogador;
            }
        }, rodada, competicao, posicao);

    }

    public OpcaoJogador salvarOpcaoJogador(OpcaoJogador opcaoJogador) {
        
        KeyHolder holder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, opcaoJogador.getJogador().getId());
                ps.setInt(2, opcaoJogador.getRodada().getId());
                ps.setInt(3, opcaoJogador.getBoaPontuacao());
                ps.setString(4, opcaoJogador.getPosicao());
                return ps;
            }
        }, holder);

        Integer id = (Integer) holder.getKeys().get("id");
        opcaoJogador.setId(id);
            
        return opcaoJogador;

    }
}


