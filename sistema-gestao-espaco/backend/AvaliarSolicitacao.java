import java.sql.*;
import org.json.JSONObject;

public class AvaliarSolicitacao {
    public static String salvar(String jsonString) {
        JSONObject obj = new JSONObject(jsonString);

        int idSolicitacao = obj.getInt("idSolicitacao");
        int idGestor = obj.getInt("idGestor");
        String status = obj.getString("status");
        String justificativa = obj.optString("justificativa", null);

        try (Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/espacos", "postgres", "senha")) {
            conn.setAutoCommit(false);

            PreparedStatement ps1 = conn.prepareStatement("""
                INSERT INTO Avaliacoes (id_solicitacao, id_gestor, status, justificativa, data_avaliacao)
                VALUES (?, ?, ?, ?, CURRENT_DATE)
            """);
            ps1.setInt(1, idSolicitacao);
            ps1.setInt(2, idGestor);
            ps1.setString(3, status);
            ps1.setString(4, justificativa);
            ps1.executeUpdate();

            PreparedStatement ps2 = conn.prepareStatement("UPDATE Solicitações SET status = ? WHERE id_solicitacao = ?");
            ps2.setString(1, status);
            ps2.setInt(2, idSolicitacao);
            ps2.executeUpdate();

            conn.commit();
            return "Solicitação " + status.toLowerCase() + " com sucesso.";
        } catch (SQLException e) {
            return "Erro ao avaliar solicitação: " + e.getMessage();
        }
    }
}