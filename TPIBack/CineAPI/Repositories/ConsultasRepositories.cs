using CineAPI.Utils;
using System;
using System.Data;
using System.Data.SqlClient;

namespace CineAPI.Repositories
{
    public class ConsultasRepositories
    {
        public class Consulta1
        {
            public string Genero { get; set; }
            public decimal PuntuacionPromedio { get; set; }
        }
        public class Consulta2
        {
            public string Nombre { get; set; }
            public string Apellido { get; set; }
            public int Reservas { get; set; }
        }
        public class Consulta3
        {
            public string Sucursal { get; set; }
            public decimal Ingreso { get; set; }
        }
        public class Consulta4
        {
            public string Pelicula { get; set; }
            public string Sucursal { get; set; }
            public DateTime Fecha { get; set; }
            public TimeOnly Horario { get; set; }
            public int AsientosDisponibles { get; set; }
        }
        public class Consulta5
        {
            public string Titulo { get; set; }
            public decimal Puntuacion { get; set; }
            public string Genero { get; set; }
        }
        public class Consulta6
        {
            public int IdCliente { get; set; }
            public string Cliente { get; set; }
            public string Asiento { get; set; }
            public string Descuento { get; set; }
            public int Reservas { get; set; }
        }
        public class Consulta7
        {
            public string Pelicula { get; set; }
            public decimal TotalIngresos { get; set; }
        }
        public class Consulta8
        {
            public int IdDirector { get; set; }
            public string Director { get; set; }
            public int CantidadPeliculas { get; set; }
            public decimal Puntuacion { get; set; }
        }

        public List<Consulta1> Consulta01(decimal puntuacion)
        {
            List<Consulta1> lst = new List<Consulta1>();
            var helper = DataHelper.GetInstance();

            DataTable t = helper.ExecuteSPQuery("SP_CONSULTA1", new SqlParameter("@puntuacion", puntuacion));
            foreach (DataRow fila in t.Rows)
            {
                Consulta1 obj = new Consulta1();
                obj.Genero = Convert.ToString(fila[0]);
                obj.PuntuacionPromedio = Convert.ToDecimal(fila[1]);
                lst.Add(obj);
            }
            return lst;
        }
        public List<Consulta2> Consulta02()
        {
            List<Consulta2> lst = new List<Consulta2>();
            var helper = DataHelper.GetInstance();

            DataTable t = helper.ExecuteSPQuery("SP_CONSULTA2");
            foreach (DataRow fila in t.Rows)
            {
                Consulta2 obj = new Consulta2();
                obj.Nombre = Convert.ToString(fila[0]);
                obj.Apellido = Convert.ToString(fila[1]);
                obj.Reservas = Convert.ToInt32(fila[2]);
                lst.Add(obj);
            }
            return lst;
        }
        public List<Consulta3> Consulta03()
        {
            List<Consulta3> lst = new List<Consulta3>();
            var helper = DataHelper.GetInstance();

            DataTable t = helper.ExecuteSPQuery("SP_CONSULTA3");
            foreach (DataRow fila in t.Rows)
            {
                Consulta3 obj = new Consulta3();
                obj.Sucursal = Convert.ToString(fila[0]);
                obj.Ingreso = Convert.ToDecimal(fila[1]);
                lst.Add(obj);
            }
            return lst;
        }
        public List<Consulta4> Consulta04()
        {
            List<Consulta4> lst = new List<Consulta4>();
            var helper = DataHelper.GetInstance();

            DataTable t = helper.ExecuteSPQuery("SP_CONSULTA4");
            foreach (DataRow fila in t.Rows)
            {
                Consulta4 obj = new Consulta4();
                obj.Pelicula = Convert.ToString(fila[0]);
                obj.Sucursal = Convert.ToString(fila[1]);
                obj.Fecha = Convert.ToDateTime(fila[2]);
                if (fila[3] is TimeSpan timeSpan)
                {
                    obj.Horario = new TimeOnly(timeSpan.Hours, timeSpan.Minutes);
                }
                obj.AsientosDisponibles = Convert.ToInt32(fila[4]);
                lst.Add(obj);
            }
            return lst;
        }
        public List<Consulta5> Consulta05()
        {
            List<Consulta5> lst = new List<Consulta5>();
            var helper = DataHelper.GetInstance();

            DataTable t = helper.ExecuteSPQuery("SP_CONSULTA5");
            foreach (DataRow fila in t.Rows)
            {
                Consulta5 obj = new Consulta5();
                obj.Titulo = Convert.ToString(fila[0]);
                obj.Puntuacion = Convert.ToDecimal(fila[1]);
                obj.Genero = Convert.ToString(fila[2]);
                lst.Add(obj);
            }
            return lst;
        }
        public List<Consulta6> Consulta06()
        {
            List<Consulta6> lst = new List<Consulta6>();
            var helper = DataHelper.GetInstance();

            DataTable t = helper.ExecuteSPQuery("SP_CONSULTA6");
            foreach (DataRow fila in t.Rows)
            {
                Consulta6 obj = new Consulta6();
                obj.IdCliente = Convert.ToInt32(fila[0]);
                obj.Cliente = Convert.ToString(fila[1]);
                obj.Asiento = Convert.ToString(fila[2]);
                obj.Descuento = Convert.ToString(fila[3]);
                obj.Reservas = Convert.ToInt32(fila[4]);
                lst.Add(obj);
            }
            return lst;
        }
        public List<Consulta7> Consulta07()
        {
            List<Consulta7> lst = new List<Consulta7>();
            var helper = DataHelper.GetInstance();

            DataTable t = helper.ExecuteSPQuery("SP_CONSULTA7");
            foreach (DataRow fila in t.Rows)
            {
                Consulta7 obj = new Consulta7();
                obj.Pelicula = Convert.ToString(fila[0]);
                obj.TotalIngresos = Convert.ToDecimal(fila[1]);
                lst.Add(obj);
            }
            return lst;
        }
        public List<Consulta8> Consulta08()
        {
            List<Consulta8> lst = new List<Consulta8>();
            var helper = DataHelper.GetInstance();

            DataTable t = helper.ExecuteSPQuery("SP_CONSULTA8");
            foreach (DataRow fila in t.Rows)
            {
                Consulta8 obj = new Consulta8();
                obj.IdDirector = Convert.ToInt32(fila[0]);
                obj.Director = Convert.ToString(fila[1]);
                obj.CantidadPeliculas = Convert.ToInt32(fila[2]);
                obj.Puntuacion = Convert.ToDecimal(fila[3]);
                lst.Add(obj);
            }
            return lst;
        }
    }
}
