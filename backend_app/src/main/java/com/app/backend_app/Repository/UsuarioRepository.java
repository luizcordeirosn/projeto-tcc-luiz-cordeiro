package com.app.backend_app.Repository;

import java.util.List;
import com.app.backend_app.Model.Usuario;

public interface UsuarioRepository {
    
    //List<Usuario> obterTodosUsuarios(Integer entidade);
    
    Usuario obterPorIdUsuario(Integer id);

    Usuario obterPorEmailSenhaUsuario(String email, String senha);

    Usuario salvarUsuario(Usuario usuario);

    Usuario atualizarUsuario(Usuario usuario);

    //Boolean deletarUsuario(Usuario usuario);
}

