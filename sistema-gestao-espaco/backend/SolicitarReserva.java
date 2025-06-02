import java.sql.*;
import org.json.JSONObject;

public class SolicitarReserva {
    public static String salvar(String jsonString) {
        JSONObject obj = new JSONObject(jsonString);

        int idSolicitante = obj.getInt("idSolicitante");
        int idEspaco = obj.getInt("idEspaco");
        String dataReserva = obj.getString("dataReserva");
        String horaReserva = obj.getString("horaReserva");

        try (Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/espacos", "postgres", "senha")) {
            PreparedStatement ps = conn.prepareStatement("""
                INSERT INTO Solicitações (id_solicitante, id_espaco, data_solicitacao, data_reserva, hora_reserva, status)
                VALUES (?, ?, CURRENT_DATE, ?, ?, 'PENDENTE')
            """);
            ps.setInt(1, idSolicitante);
            ps.setInt(2, idEspaco);
            ps.setDate(3, Date.valueOf(dataReserva));
            ps.setTime(4, Time.valueOf(horaReserva + ":00"));
            ps.executeUpdate();
            return "Solicitação registrada com sucesso.";
        } catch (SQLIntegrityConstraintViolationException e) {
            return "Erro: já existe uma reserva aprovada para este espaço neste horário.";
        } catch (SQLException e) {
            return "Erro ao registrar solicitação: " + e.getMessage();
        }
    }
}