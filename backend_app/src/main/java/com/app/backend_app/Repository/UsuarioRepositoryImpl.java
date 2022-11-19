package com.app.backend_app.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import com.app.backend_app.Model.Usuario;

@Repository
public class UsuarioRepositoryImpl implements UsuarioRepository{
    
    private static String INSERT = " insert into tb_usuario (id, nome, cpf, telefone, email, senha, "
            + " registro, planoativo) "
            + " values (nextval('tb_usuario_id_seq'),?,?,?,?,?,?,?) ";
    private static String SELECT_ONE = " select * from tb_usuario where id = ?";
    private static String SELECT_ONE_EMAIL_SENHA = " select * from tb_usuario"
            + " where email like ?"
            + " and senha like ? "
            + " order by id";

    @Autowired
    private JdbcTemplate jdbcTemplate;
        
    public void setDataSource(DataSource dataSource){
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public Usuario obterPorIdUsuario(Integer id) {

        return jdbcTemplate.queryForObject(SELECT_ONE, new Object[] {id}, new RowMapper<Usuario>() {
            @Override
            public Usuario mapRow(ResultSet rs, int rownumber) throws SQLException {
                
                Usuario usuario = new Usuario();

                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setCpf(rs.getString("cpf"));
                usuario.setTelefone(rs.getString("telefone"));
                usuario.setEmail(rs.getString("email"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setRegistro(rs.getDate("registro"));
                usuario.setPlanoAtivo(rs.getBoolean("planoativo"));

                return usuario;
            }
        });

    }

    public Usuario obterPorEmailSenhaUsuario(String email, String senha) {

        return jdbcTemplate.queryForObject(SELECT_ONE_EMAIL_SENHA, new Object[] {email, senha}, new RowMapper<Usuario>() {
            @Override
            public Usuario mapRow(ResultSet rs, int rownumber) throws SQLException {
                
                Usuario usuario = new Usuario();

                usuario.setId(rs.getInt("id"));
                usuario.setNome(rs.getString("nome"));
                usuario.setCpf(rs.getString("cpf"));
                usuario.setTelefone(rs.getString("telefone"));
                usuario.setEmail(rs.getString("email"));
                usuario.setSenha(rs.getString("senha"));
                usuario.setRegistro(rs.getDate("registro"));
                usuario.setPlanoAtivo(rs.getBoolean("planoativo"));

                return usuario;
            }
        });

    }

    public Usuario salvarUsuario(Usuario usuario) {

        Date registro = new Date();
        java.sql.Date registroSQL = new java.sql.Date(registro.getTime());
        
        KeyHolder holder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                PreparedStatement ps = connection.prepareStatement(INSERT, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, usuario.getNome());
                ps.setString(2, usuario.getCpf());
                ps.setString(3, usuario.getTelefone());
                ps.setString(4, usuario.getEmail());
                ps.setString(5, usuario.getSenha());
                ps.setDate(6, registroSQL);
                ps.setBoolean(7, false);
                return ps;
            }
        }, holder);

        Integer id = (Integer) holder.getKeys().get("id");
        usuario.setId(id);
            
        return usuario;

    }
}
