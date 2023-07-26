using Microsoft.Data.SqlClient;
using System.Data;

namespace PromericaPrueba.Conector
{
    public class RepoConector
    {
        private SqlConnection _connection=new();
        private SqlCommand _command;
        private SqlDataAdapter _adapter;
        private DataSet _dataSet;

        public RepoConector()
        {

            _connection = new SqlConnection("Server=.;DataBase=PruebaPromerica;Trusted_Connection=True;TrustServerCertificate=True;");
        }

        public int Filas(string query)
        {
            int affect = -1;
            try
            {
                _connection.Open();

                _command = new SqlCommand(query, _connection);

                 affect=  _command.ExecuteNonQuery();
                _connection.Close();

                if (affect == -1) {
                    _dataSet = ObtenerDatos(query);

                    var count = _dataSet.Tables[0].Rows.Count;

                    if (count > 0){affect = count;}
                }
                return affect <0 ? 0 : affect;
            }
            catch (Exception ex)
            {
                _connection.Close();
                return -1;
            }
        }

        public DataSet ObtenerDatos(string query)
        {
            try
            {
                _connection.Open();

                _command = new SqlCommand(query, _connection);

                _dataSet = new DataSet();
                _adapter = new SqlDataAdapter(_command);
                _adapter.Fill(_dataSet);

                _connection.Close();
                return _dataSet;
            }
            catch (Exception ex)
            {
                _connection.Close();
                return null;
            }
        }
    }
}
