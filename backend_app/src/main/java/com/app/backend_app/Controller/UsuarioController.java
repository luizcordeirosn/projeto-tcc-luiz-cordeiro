package com.app.backend_app.Controller;

import java.sql.SQLException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.app.backend_app.Model.Usuario;
import com.app.backend_app.Model.UsuarioInput;
import com.app.backend_app.Repository.UsuarioRepository;
import com.app.backend_app.util.exceptions.DomainException;

@RestController
@RequestMapping(value = "/usuario")
@Transactional
@Controller
public class UsuarioController {

    @Autowired
    private UsuarioRepository usuarioRepo;

    @GetMapping(value = "/{id}")
    public ResponseEntity<Usuario> usuario(@PathVariable Integer id) {

        try {
            Usuario usuario = usuarioRepo.obterPorIdUsuario(id);
            return ResponseEntity.ok(usuario);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @GetMapping(value = "/verificar")
    public ResponseEntity<Usuario> verificarUsuarioEmailSenha(@RequestParam String email,
            @RequestParam String senha) {

        try {
            Usuario usuario = usuarioRepo.obterPorEmailSenhaUsuario(email, senha);
            return ResponseEntity.ok(usuario);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @PostMapping(value = "/salvar")
    public ResponseEntity<Usuario> salvarVeiculo(@RequestBody UsuarioInput usuarioInput) throws SQLException {

        Usuario usuario = new Usuario();

        usuario.setNome(usuarioInput.getNome());
        usuario.setCpf(usuarioInput.getCpf());
        usuario.setTelefone(usuarioInput.getTelefone());
        usuario.setEmail(usuarioInput.getEmail());
        usuario.setSenha(usuarioInput.getSenha());

        try {
            if (usuarioInput.getId() == 0) {
                usuario = usuarioRepo.salvarUsuario(usuario);
            } else {
                usuario.setId(usuarioInput.getId());
                // usuario = usuarioRepo.atualizarUsuario(usuario);
            }
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }

        return ResponseEntity.ok(usuario);
    }
}
