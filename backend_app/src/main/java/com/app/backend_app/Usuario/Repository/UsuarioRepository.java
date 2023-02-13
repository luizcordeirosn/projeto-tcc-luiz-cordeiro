package com.app.backend_app.Usuario.Repository;

import com.app.backend_app.Usuario.Model.Usuario;

public interface UsuarioRepository {
    
    Usuario obterPorIdUsuario(Integer id);

    Usuario obterPorEmailSenhaUsuario(String email, String senha);

    Usuario salvarUsuario(Usuario usuario);

    Usuario atualizarUsuario(Usuario usuario);

}

