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
import com.app.backend_app.Futebol.Model.Classificacao;

@Repository
public class ClassificacaoRepositoryImpl implements ClassificacaoRepository{
    
    private static String INSERT = " insert into tb_classificacao (id, competicao, posicao, time, pontos, "
            + " numjogos, numvitorias, numempates, numderrotas, golspro, golscontra, saldogol, "
            + " resultadosrecentes) "
            + " values (nextval('tb_classificacao_id_seq'),?,?,?,?,?,?,?,?,?,?,?,?) ";
    private static String SELECT_ONE = " select * from tb_classificacao where id = ?";
    private static String SELECT_ALL_COMPETICAO = " select * from tb_classificacao where competicao = ?"
            + " order by posicao, id";

    @Autowired
    private CompeticaoRepository competicaoRepo;

    @Autowired
    private TimeRepository timeRepo;

    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public void setDataSource(DataSource dataSource){
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Classificacao obterPorIdClassificacao(Integer id) {

        return jdbcTemplate.queryForObject(SELECT_ONE, new Object[] {id}, new RowMapper<Classificacao>() {
            @Override
            public Classificacao mapRow(ResultSet rs, int rownumber) throws SQLException {
                
                Classificacao classificacao = new Classificacao();

                classificacao.setId(rs.getInt("id"));

                Integer competicaoId = rs.getInt("competicao");
                Competicao competicao = competicaoRepo.obterPorIdCompeticao(competicaoId);
                classificacao.setCompeticao(competicao);

                classificacao.setPosicao(rs.getInt("posicao"));

                Integer timeId = rs.getInt("time");
                Time time = timeRepo.obterPorIdTime(timeId);
                classificacao.setTime(time);

                classificacao.setPontos(rs.getInt("pontos"));
                classificacao.setNumJogos(rs.getInt("numjogos"));
                classificacao.setNumVitorias(rs.getInt("numvitorias"));
                classificacao.setNumEmpates(rs.getInt("numempates"));
                classificacao.setNumDerrotas(rs.getInt("numderrotas"));
                classificacao.setGolsPro(rs.getInt("golspro"));
                classificacao.setGolsContra(rs.getInt("golscontra"));
                classificacao.setSaldoGol(rs.getInt("saldogol"));
                classificacao.setResultadosRecentes(rs.getString("resultadosrecentes"));

                return classificacao;
            }
        });

    }

    public List<Classificacao> obterTodosClassificacaoPorCompeticao(Integer competicao) {
        
        return jdbcTemplate.query(SELECT_ALL_COMPETICAO, new RowMapper<Classificacao>() {
            @Override
            public Classificacao mapRow(ResultSet rs, int rownumber) throws SQLException {

                Classificacao classificacao = new Classificacao();

                classificacao.setId(rs.getInt("id"));

                Integer competicaoId = rs.getInt("competicao");
                Competicao competicao = competicaoRepo.obterPorIdCompeticao(competicaoId);
                classificacao.setCompeticao(competicao);

                classificacao.setPosicao(rs.getInt("posicao"));

                Integer timeId = rs.getInt("time");
                Time time = timeRepo.obterPorIdTime(timeId);
                classificacao.setTime(time);

                classificacao.setPontos(rs.getInt("pontos"));
                classificacao.setNumJogos(rs.getInt("numjogos"));
                classificacao.setNumVitorias(rs.getInt("numvitorias"));
                classificacao.setNumEmpates(rs.getInt("numempates"));
                classificacao.setNumDerrotas(rs.getInt("numderrotas"));
                classificacao.setGolsPro(rs.getInt("golspro"));
                classificacao.setGolsContra(rs.getInt("golscontra"));
                classificacao.setSaldoGol(rs.getInt("saldogol"));
                classificacao.setResultadosRecentes(rs.getString("resultadosrecentes"));

                return classificacao;
            }
        }, competicao);

    }

    public Classificacao salvarClassificacao(Classificacao classificacao) {
        
        KeyHolder holder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, classificacao.getCompeticao().getId());
                ps.setInt(2, classificacao.getPosicao());
                ps.setInt(3, classificacao.getTime().getId());
                ps.setInt(4, classificacao.getPontos());
                ps.setInt(5, classificacao.getNumJogos());
                ps.setInt(6, classificacao.getNumVitorias());
                ps.setInt(7, classificacao.getNumEmpates());
                ps.setInt(8, classificacao.getNumDerrotas());
                ps.setInt(9, classificacao.getGolsPro());
                ps.setInt(10, classificacao.getGolsContra());
                ps.setInt(11, classificacao.getSaldoGol());
                ps.setString(12, classificacao.getResultadosRecentes());
                return ps;
            }
        }, holder);

        Integer id = (Integer) holder.getKeys().get("id");
        classificacao.setId(id);
            
        return classificacao;

    }
}

