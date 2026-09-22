package com.tugas.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet untuk menghitung Persegi Panjang (Soal 1 & 2)
 * - Soal 1: Menghitung Luas dan Keliling
 * - Soal 2: Mendeteksi apakah Bujur Sangkar atau Persegi Panjang
 */
public class PersegiPanjangServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ambil input dari form
        double panjang = Double.parseDouble(request.getParameter("panjang"));
        double lebar = Double.parseDouble(request.getParameter("lebar"));

        // === SOAL 1: Hitung Luas dan Keliling ===
        double luas = panjang * lebar;
        double keliling = 2 * (panjang + lebar);

        // === SOAL 2: Deteksi jenis bentuk ===
        String jenis;
        if (panjang == lebar) {
            jenis = "BUJUR SANGKAR";
        } else {
            jenis = "PERSEGI PANJANG";
        }

        // Set atribut untuk dikirim ke JSP hasil
        request.setAttribute("panjang", panjang);
        request.setAttribute("lebar", lebar);
        request.setAttribute("luas", luas);
        request.setAttribute("keliling", keliling);
        request.setAttribute("jenis", jenis);

        // Forward ke halaman hasil
        request.getRequestDispatcher("hasilpersegi.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect ke form input jika diakses langsung via GET
        response.sendRedirect("persegipanjang.jsp");
    }
}
