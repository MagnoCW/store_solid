abstract class Report {
  void generate(String data);
}

class PDFReport extends Report {
  @override
  void generate(String data) {
    print("Generating PDF report with data: $data");
  }
}

class ExcelReport extends Report {
  @override
  void generate(String data) {
    print("Generating Excel report with data: $data");
  }
}
