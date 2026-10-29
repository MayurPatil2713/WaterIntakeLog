<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Water Intake Log</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f7fb;
        }

        h2 {
            text-align: center;
            color: #1f3864;
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
            background: white;
        }

        th {
            background: #1f3864;
            color: white;
            padding: 10px;
        }

        td {
            border: 1px solid #888;
            padding: 8px;
            text-align: center;
        }

        .average {
            text-align: center;
            font-size: 18px;
            color: #087443;
            font-weight: bold;
        }

        a {
            color: #1f3864;
        }
    </style>
</head>

<body>

<%
    request.setCharacterEncoding("UTF-8");

    String person = request.getParameter("person");
    String logDate = request.getParameter("log_date");
    String glassesText = request.getParameter("glasses");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        try (
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/water_intake_db",
                "root",
                ""
            )
        ) {
            // Save the record when the form is submitted
            if (person != null && logDate != null
                    && glassesText != null) {

                person = person.trim();
                logDate = logDate.trim();
                glassesText = glassesText.trim();

                if (!person.isEmpty() && !logDate.isEmpty()
                        && !glassesText.isEmpty()) {

                    int glasses = Integer.parseInt(glassesText);

                    if (glasses >= 0 && glasses <= 20) {
                        try (
                            PreparedStatement ps = con.prepareStatement(
                                "INSERT INTO water_log " +
                                "(person, log_date, glasses) " +
                                "VALUES (?, ?, ?)"
                            )
                        ) {
                            ps.setString(1, person);
                            ps.setDate(2, Date.valueOf(logDate));
                            ps.setInt(3, glasses);
                            ps.executeUpdate();
                        }
                    } else {
                        out.println(
                            "<p style='text-align:center;color:red'>" +
                            "Glasses must be between 0 and 20.</p>"
                        );
                    }
                }
            }
%>

<h2>Water Intake Log - All Records</h2>

<table>
    <tr>
        <th>ID</th>
        <th>Person</th>
        <th>Date</th>
        <th>Glasses</th>
    </tr>

<%
            try (
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(
                    "SELECT * FROM water_log ORDER BY log_date DESC, id DESC"
                )
            ) {
                while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("person") %></td>
        <td><%= rs.getDate("log_date") %></td>
        <td><%= rs.getInt("glasses") %></td>
    </tr>
<%
                }
            }

            // Calculate average water intake
            try (
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(
                    "SELECT AVG(glasses) AS average_glasses FROM water_log"
                )
            ) {
                if (rs.next()) {
                    double average = rs.getDouble("average_glasses");
                    if (!rs.wasNull()) {
%>
<p class="average">
    Average Water Intake:
    <%= String.format("%.2f", average) %> glasses
</p>
<%
                    } else {
%>
<p class="average">No records available yet.</p>
<%
                    }
                }
            }
        }
    } catch (Exception e) {
        out.println(
            "<p style='text-align:center;color:red'>" +
            "Error: " + e.getMessage() + "</p>"
        );
    }
%>

<p style="text-align:center">
    <a href="index.html">Add Another Record</a>
</p>

</body>
</html>