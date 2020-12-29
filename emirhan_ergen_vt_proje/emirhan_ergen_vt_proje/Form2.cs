using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;

namespace emirhan_ergen_vt_proje
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            add_film(baslik.Text, intro.Text, vizyon_tarihi.Text, dil.SelectedIndex + 1, Convert.ToInt32(sure.Value), imdb_puan.Text);
            all_films();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void Form2_Load(object sender, EventArgs e)
        {
            
            dil.Items.Add("Türkçe");
            dil.Items.Add("İngilizce");
            dil.Items.Add("Rusca");
            all_films();
            id.Maximum = 2147483647;
            id.Minimum = 0;
            sure.Maximum = 230;
            sure.Minimum = 20;
            Form1 form1 = new Form1();
            form1.Close();

        }
        public void add_film(string baslik, string intro,string vizyon_tarihi, int dil_id, int sure, string imdb_puan )
        {
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5433; Database=Emirhan_Ergen_Proje_Vt; User Id=postgres; Password=1;");
            try { conn.Open(); } catch (Exception e) { }
            string sql = "INSERT INTO film (baslik,intro,vizyon_tarihi,dil_id,sure,imdb_puan) values ('" + baslik + "','" + intro + "','" + vizyon_tarihi + "','" + dil_id + "','" + sure + "','" + imdb_puan + "')";
            NpgsqlCommand cmd = new NpgsqlCommand(sql, conn);
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        public void all_films()
        {
            listBox1.Items.Clear();
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5433; Database=Emirhan_Ergen_Proje_Vt; User Id=postgres; Password=1;");
            conn.Open();
            string sql = "SELECT \"film_id\", \"baslik\",\"vizyon_tarihi\",\"sure\",\"imdb_puan\" FROM \"film\"";
            // Define a query returning a single row result set
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);

            NpgsqlDataReader dr = command.ExecuteReader();
            while (dr.Read())
            {
                listBox1.Items.Add(dr[0].ToString()+"-) "+dr[1].ToString() + " Yıl:" + dr[2].ToString()+" Süre:"+dr[3].ToString()+" İMDB PUANI:"+dr[4].ToString());

            }
            conn.Close();

        }

        public void update_film(string baslik,string imdb_puan,int id)
        {
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5433; Database=Emirhan_Ergen_Proje_Vt; User Id=postgres; Password=1;");
            try { conn.Open(); } catch (Exception e) { }

            string sql = "UPDATE \"film\" SET \"baslik\"=\'" + baslik +"\',\"imdb_puan\"=\'" + imdb_puan + "\' WHERE \"film_id\"=\'" + id + "\'";
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);
            command.ExecuteNonQuery();
            conn.Close();
        }

        public void delete_movie(int id)
        {
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5433; Database=Emirhan_Ergen_Proje_Vt; User Id=postgres; Password=1;");
            try { conn.Open(); } catch (Exception e) { }

            string sql = "DELETE FROM film WHERE film_id ='" + id + "'";
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);
            command.ExecuteNonQuery();
            conn.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            update_film(baslik.Text, imdb_puan.Text,Convert.ToInt32(id.Value));

            all_films();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            delete_movie(Convert.ToInt32(id.Value));
            all_films();
        }

        private void id_ValueChanged(object sender, EventArgs e)
        {

        }

        private void lenght_ValueChanged(object sender, EventArgs e)
        {

        }

        private void imdb_puan_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void imdb_puan_KeyPress(object sender, KeyPressEventArgs e)
        {
            char ch = e.KeyChar;
            if (ch == 46 && imdb_puan.Text.IndexOf('.') != -1)
            {
                e.Handled = true;
                return;
            }

            if (!Char.IsDigit(ch) && ch!=8 &&ch!=46)
            {
                e.Handled = true;
            }
        }
    }
}
