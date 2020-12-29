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
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form2 form2 = new Form2();
            
            if (giris(textBox1.Text, textBox2.Text) == true) {
                form2.Show();
            }
            else
                MessageBox.Show("Hatalı Giriş");
            
            
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
        public bool giris(string kullanici_adi,string parola)
        {
            NpgsqlConnection conn = new NpgsqlConnection("Server=localhost; Port=5433; Database=Emirhan_Ergen_Proje_Vt; User Id=postgres; Password=1;");
            conn.Open();
            string sql = "SELECT parola FROM personel WHERE kullanici_adi ='" + kullanici_adi + "'";
            NpgsqlCommand command = new NpgsqlCommand(sql, conn);

            string sifre = command.ExecuteScalar().ToString();
            conn.Close();
            if (parola == sifre)
                return true;
            else
                return false;
            

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            MessageBox.Show("Var olan personel yada yeni eklenen personellerle giriş yapmayı deneyin !! " +
                            "Aksi taktirde çalışmaz!!! " +
                            "(Örneğin) " +
                            "Kullanıcı Adı :'emiirrhan' " +
                            "Şifre: '123456789'");
        }
    }
}
