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
import com.app.backend_app.Futebol.Model.Escalacao;
import com.app.backend_app.Futebol.Model.Jogador;
import com.app.backend_app.Futebol.Model.Rodada;

@Repository
public class EscalacaoRepositoryImpl implements EscalacaoRepository{
    
    private static String INSERT = " insert into tb_escalacao (id, formacao, rodada, jogador, tipoposicao,"
            + " capitao) " 
            + " values (nextval('tb_escalacao_id_seq'),?,?,?,?,?) ";
    private static String SELECT_ONE = " select * from tb_escalacao where id = ?";
    private static String SELECT_ALL_RODADA_COMPETICAO = " select te.* from tb_escalacao te"
            + " inner join tb_rodada tr on tr.id = te.rodada"
            + " inner join tb_jogador tj on tj.id = te.jogador"
            + " where te.rodada = ? and tr.competicao = ?"
            + " order by te.tipoposicao, tj.nome, te.id";
            
    @Autowired
    private RodadaRepository rodadaRepo;

    @Autowired
    private JogadorRepository jogadorRepo;

    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public void setDataSource(DataSource dataSource){
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Escalacao obterPorIdEscalacao(Integer id) {

        return jdbcTemplate.queryForObject(SELECT_ONE, new Object[] {id}, new RowMapper<Escalacao>() {
            @Override
            public Escalacao mapRow(ResultSet rs, int rownumber) throws SQLException {
                
                Escalacao escalacao = new Escalacao();

                escalacao.setId(rs.getInt("id"));
                escalacao.setFormacao(rs.getString("formacao"));

                Integer rodadaId = rs.getInt("rodada");
                Rodada rodada = rodadaRepo.obterPorIdRodada(rodadaId);
                escalacao.setRodada(rodada);

                Integer jogadorId = rs.getInt("jogador");
                Jogador jogador = jogadorRepo.obterPorIdJogador(jogadorId);
                escalacao.setJogador(jogador);

                escalacao.setTipoPosicao(rs.getInt("tipoposicao"));
                escalacao.setCapitao(rs.getBoolean("capitao"));

                return escalacao;
            }
        });

    }

    public List<Escalacao> obterTodosEscalacoesPorRodadaCompeticao(Integer rodada, Integer competicao) {
        
        return jdbcTemplate.query(SELECT_ALL_RODADA_COMPETICAO, new RowMapper<Escalacao>() {
            @Override
            public Escalacao mapRow(ResultSet rs, int rownumber) throws SQLException {

                Escalacao escalacao = new Escalacao();

                escalacao.setId(rs.getInt("id"));
                escalacao.setFormacao(rs.getString("formacao"));

                Integer rodadaId = rs.getInt("rodada");
                Rodada rodada = rodadaRepo.obterPorIdRodada(rodadaId);
                escalacao.setRodada(rodada);

                Integer jogadorId = rs.getInt("jogador");
                Jogador jogador = jogadorRepo.obterPorIdJogador(jogadorId);
                escalacao.setJogador(jogador);

                escalacao.setTipoPosicao(rs.getInt("tipoposicao"));
                escalacao.setCapitao(rs.getBoolean("capitao"));

                return escalacao;
            }
        }, rodada, competicao);

    }

    public Escalacao salvarEscalacao(Escalacao escalacao) {
        
        KeyHolder holder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, escalacao.getFormacao());
                ps.setInt(2, escalacao.getRodada().getId());
                ps.setInt(3, escalacao.getJogador().getId());
                ps.setInt(4, escalacao.getTipoPosicao());
                ps.setBoolean(5, escalacao.getCapitao());
                return ps;
            }
        }, holder);

        Integer id = (Integer) holder.getKeys().get("id");
        escalacao.setId(id);
            
        return escalacao;

    }
}


