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
import com.app.backend_app.Futebol.Model.RelatorioGol;

@Repository
public class RelatorioGolRepositoryImpl implements RelatorioGolRepository{
    
    private static String INSERT = " insert into tb_relatoriogol (id, confronto, "
            + " golsmarcadosbpm, golsmarcadospm, golsmarcadosmm, golsmarcadosdm, golsmarcadosem,"
            + " golssofridosbpm, golssofridospm, golssofridosmm, golssofridosdm, golssofridosem, "
            + " golsmarcadosbpv, golsmarcadospv, golsmarcadosmv, golsmarcadosdv, golsmarcadosev, "
            + " golssofridosbpv, golssofridospv, golssofridosmv, golssofridosdv, golssofridosev)"
            + " values (nextval('tb_relatoriogol_id_seq'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
    private static String SELECT_ONE = " select * from tb_relatoriogol where id = ?";
    private static String SELECT_ALL_RODADA_COMPETICAO = " select trg.* from tb_relatoriogol trg"
            + " inner join tb_confronto tc on tc.id = trg.confronto"
            + " inner join tb_rodada tr on tr.id = tc.rodada"
            + " where tr.id = ? and tr.competicao = ?"
            + " order by tc.datahora, trg.id";

    @Autowired
    private ConfrontoRepository confrontoRepo;
            
    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public void setDataSource(DataSource dataSource){
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public RelatorioGol obterPorIdRelatorioGol(Integer id) {

        return jdbcTemplate.queryForObject(SELECT_ONE, new Object[] {id}, new RowMapper<RelatorioGol>() {
            @Override
            public RelatorioGol mapRow(ResultSet rs, int rownumber) throws SQLException {
                
                RelatorioGol relatorioGol = new RelatorioGol();

                relatorioGol.setId(rs.getInt("id"));

                Integer confrontoId = rs.getInt("confronto");
                Confronto confronto = confrontoRepo.obterPorIdConfronto(confrontoId);
                relatorioGol.setConfronto(confronto);

                relatorioGol.setGolsMarcadosBPM(rs.getInt("golsmarcadosbpm"));
                relatorioGol.setGolsMarcadosPM(rs.getInt("golsmarcadospm"));
                relatorioGol.setGolsMarcadosMM(rs.getInt("golsmarcadosmm"));
                relatorioGol.setGolsMarcadosDM(rs.getInt("golsmarcadosdm"));
                relatorioGol.setGolsMarcadosEM(rs.getInt("golsmarcadosem"));
                relatorioGol.setGolsSofridosBPM(rs.getInt("golssofridosbpm"));
                relatorioGol.setGolsSofridosPM(rs.getInt("golssofridospm"));
                relatorioGol.setGolsSofridosMM(rs.getInt("golssofridosmm"));
                relatorioGol.setGolsSofridosDM(rs.getInt("golssofridosdm"));
                relatorioGol.setGolsSofridosEM(rs.getInt("golssofridosem"));
                relatorioGol.setGolsMarcadosBPV(rs.getInt("golsmarcadosbpv"));
                relatorioGol.setGolsMarcadosPV(rs.getInt("golsmarcadospv"));
                relatorioGol.setGolsMarcadosMV(rs.getInt("golsmarcadosmv"));
                relatorioGol.setGolsMarcadosDV(rs.getInt("golsmarcadosdv"));
                relatorioGol.setGolsMarcadosEV(rs.getInt("golsmarcadosev"));
                relatorioGol.setGolsSofridosBPV(rs.getInt("golssofridosbpv"));
                relatorioGol.setGolsSofridosPV(rs.getInt("golssofridospv"));
                relatorioGol.setGolsSofridosMV(rs.getInt("golssofridosmv"));
                relatorioGol.setGolsSofridosDV(rs.getInt("golssofridosdv"));
                relatorioGol.setGolsSofridosEV(rs.getInt("golssofridosev"));

                return relatorioGol;
            }
        });

    }

    public List<RelatorioGol> obterTodosRelatoriosGolPorRodadaCompeticao(Integer rodada, Integer competicao) {
        
        return jdbcTemplate.query(SELECT_ALL_RODADA_COMPETICAO, new RowMapper<RelatorioGol>() {
            @Override
            public RelatorioGol mapRow(ResultSet rs, int rownumber) throws SQLException {

                RelatorioGol relatorioGol = new RelatorioGol();

                relatorioGol.setId(rs.getInt("id"));

                Integer confrontoId = rs.getInt("confronto");
                Confronto confronto = confrontoRepo.obterPorIdConfronto(confrontoId);
                relatorioGol.setConfronto(confronto);

                relatorioGol.setGolsMarcadosBPM(rs.getInt("golsmarcadosbpm"));
                relatorioGol.setGolsMarcadosPM(rs.getInt("golsmarcadospm"));
                relatorioGol.setGolsMarcadosMM(rs.getInt("golsmarcadosmm"));
                relatorioGol.setGolsMarcadosDM(rs.getInt("golsmarcadosdm"));
                relatorioGol.setGolsMarcadosEM(rs.getInt("golsmarcadosem"));
                relatorioGol.setGolsSofridosBPM(rs.getInt("golssofridosbpm"));
                relatorioGol.setGolsSofridosPM(rs.getInt("golssofridospm"));
                relatorioGol.setGolsSofridosMM(rs.getInt("golssofridosmm"));
                relatorioGol.setGolsSofridosDM(rs.getInt("golssofridosdm"));
                relatorioGol.setGolsSofridosEM(rs.getInt("golssofridosem"));
                relatorioGol.setGolsMarcadosBPV(rs.getInt("golsmarcadosbpv"));
                relatorioGol.setGolsMarcadosPV(rs.getInt("golsmarcadospv"));
                relatorioGol.setGolsMarcadosMV(rs.getInt("golsmarcadosmv"));
                relatorioGol.setGolsMarcadosDV(rs.getInt("golsmarcadosdv"));
                relatorioGol.setGolsMarcadosEV(rs.getInt("golsmarcadosev"));
                relatorioGol.setGolsSofridosBPV(rs.getInt("golssofridosbpv"));
                relatorioGol.setGolsSofridosPV(rs.getInt("golssofridospv"));
                relatorioGol.setGolsSofridosMV(rs.getInt("golssofridosmv"));
                relatorioGol.setGolsSofridosDV(rs.getInt("golssofridosdv"));
                relatorioGol.setGolsSofridosEV(rs.getInt("golssofridosev"));

                return relatorioGol;
            }
        }, rodada, competicao);

    }

    public RelatorioGol salvarRelatorioGol(RelatorioGol relatorioGol) {
        
        KeyHolder holder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, relatorioGol.getConfronto().getId());
                ps.setInt(2, relatorioGol.getGolsMarcadosBPM());
                ps.setInt(3, relatorioGol.getGolsMarcadosPM());
                ps.setInt(4, relatorioGol.getGolsMarcadosMM());
                ps.setInt(5, relatorioGol.getGolsMarcadosDM());
                ps.setInt(6, relatorioGol.getGolsMarcadosEM());
                ps.setInt(7, relatorioGol.getGolsSofridosBPM());
                ps.setInt(8, relatorioGol.getGolsSofridosPM());
                ps.setInt(9, relatorioGol.getGolsSofridosMM());
                ps.setInt(10, relatorioGol.getGolsSofridosDM());
                ps.setInt(11, relatorioGol.getGolsSofridosEM());
                ps.setInt(12, relatorioGol.getGolsMarcadosBPV());
                ps.setInt(13, relatorioGol.getGolsMarcadosPV());
                ps.setInt(14, relatorioGol.getGolsMarcadosMV());
                ps.setInt(15, relatorioGol.getGolsMarcadosDV());
                ps.setInt(16, relatorioGol.getGolsMarcadosEV());
                ps.setInt(17, relatorioGol.getGolsSofridosBPV());
                ps.setInt(18, relatorioGol.getGolsSofridosPV());
                ps.setInt(19, relatorioGol.getGolsSofridosMV());
                ps.setInt(20, relatorioGol.getGolsSofridosDV());
                ps.setInt(21, relatorioGol.getGolsSofridosEV());
                return ps;
            }
        }, holder);

        Integer id = (Integer) holder.getKeys().get("id");
        relatorioGol.setId(id);
            
        return relatorioGol;

    }
}


