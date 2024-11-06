using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CineAPI.Utils
{
    public class DataHelper
    {
        private static DataHelper _instancia;
        private SqlConnection _connection;

        private DataHelper()
        {
            _connection = new SqlConnection(@"Data Source=(localdb)\FacuGino;Initial Catalog=Cine;Integrated Security=True");
        }

        public static DataHelper GetInstance() // Patrón singleton para evitar que se genere múltiples veces el DataHelper
        {
            if (_instancia == null)
            {
                _instancia = new DataHelper();
            }
            return _instancia;
        }
        public DataTable ExecuteSPQuery(string sp, params SqlParameter[] parameters)
        {
            DataTable t = new DataTable();
            try
            {
                _connection.Open();
                var cmd = new SqlCommand(sp, _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                if (parameters != null)
                {
                    cmd.Parameters.AddRange(parameters);
                }
                t.Load(cmd.ExecuteReader());
                _connection.Close();
            }
            catch (SqlException)
            {
                t = null;
            }
            return t;
        }
    }
}
