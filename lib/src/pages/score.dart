import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/src/functions/GlobalState.dart';
import 'package:http/http.dart' as http;

class Students {
  final String e_id;
  final String id_card;
  final String at_id;
  final String lv_id;
  final String group;
  final String enrollment_date;
  final String status;
  final String folio_at_scores;
  final String weekly_load;
  final String enrollment_number;
  final String u_id;
  final String first_name;
  final String last_name;
  final String login;
  final String nid;
  final String nid_city_id;
  final String birth_city_id;
  final String nid_type;
  final String blood_type;
  final String b_id;
  final String p_id;
  final String access_code;
  final String guardian_nid;
  final String guardian_first_name;
  final String guardian_last_name;
  final String folio_enrollment;
  final String enrollment_status;
  final String name;
  final String full_name;
  final String grupo;
  final String estado;
  final String fecha_matricula;
  final String documento;
  final String lastname;
  final String fullname;
  final String nombres;
  final String apellidos;
  Students(this.e_id, this.id_card, this.at_id, this.lv_id, this.group, this.enrollment_date, this.status, this.folio_at_scores, this.weekly_load, this.enrollment_number, this.u_id, this.first_name, this.last_name, this.login, this.nid, this.nid_city_id, this.birth_city_id, this.nid_type, this.blood_type, this.b_id, this.p_id, this.access_code, this.guardian_nid, this.guardian_first_name, this.guardian_last_name, this.folio_enrollment, this.enrollment_status, this.name, this.full_name, this.grupo, this.estado, this.fecha_matricula, this.documento, this.lastname, this.fullname, this.nombres, this.apellidos);
}

class Courses {
  final String c_id;
  final String s_id;
  final String at_id;
  final String ev_id;
  final String lev_id;
  final String credits;
  final String weekly_load;
  final String percentage_in_the_area;
  final String mandatory_enrollment;
  final String mandatory_approval;
  final String influences_academic_performance;
  final String allows_score;
  final String has_same_groups_as_level;
  final int use_standards;
  final int use_assignments;
  final int use_massive_assignments;
  final int use_comments;
  final String assignments_score_format;
  final String standards_score_format;
  final String final_score_format;
  final String weighting_elements;
  final String weighting_criteria;
  final String order;
  final String always_allow_to_grade;
  final String ar_id;
  final String lv_id;
  final String name;
  final String description;
  final String next_s_id;
  final String prev_s_id;
  final String level_name;
  final String full_name;
  final String spe_id;
  final String allow_different_standards_among_teachers;
  final String scores_range__lower_limit;
  final String scores_range__upper_limit;
  final String scores_range__jump_values_each;
  final String format;
  final String original_final_score_format;
  final int year_time_intensity;
  final String score;
  Courses(this.c_id, this.s_id, this.at_id, this.ev_id, this.lev_id, this.credits, this.weekly_load, this.percentage_in_the_area, this.mandatory_enrollment, this.mandatory_approval, this.influences_academic_performance, this.allows_score, this.has_same_groups_as_level, this.use_standards, this.use_assignments, this.use_massive_assignments, this.use_comments, this.assignments_score_format, this.standards_score_format, this.final_score_format, this.weighting_elements, this.weighting_criteria, this.order, this.always_allow_to_grade, this.ar_id, this.lv_id, this.name, this.description, this.next_s_id, this.prev_s_id, this.level_name, this.full_name, this.spe_id, this.allow_different_standards_among_teachers, this.scores_range__lower_limit, this.scores_range__upper_limit, this.scores_range__jump_values_each, this.format, this.original_final_score_format, this.year_time_intensity, this.score);
}

class StudentCourse {
  final String et_id;
  final String e_id;
  final String report_id;
  final String ar_id;
  final String c_id;
  final String absences_justified;
  final String absences_not_justified;
  final String initial_score;
  final String leveling;
  final String score;
  final String comments;
  final String last_updated;
  final String insertion_date;
  StudentCourse(this.et_id, this.e_id, this.report_id, this.ar_id, this.c_id, this.absences_justified, this.absences_not_justified, this.initial_score, this.leveling, this.score, this.comments, this.last_updated, this.insertion_date);
}

String stutentId;

class ScorePage extends StatefulWidget {
  @override
  ScorePageState createState() => new ScorePageState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;
 
  Debouncer({this.milliseconds});
 
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class ScorePageState extends State<ScorePage>  {

  var data;
  final _debouncer = Debouncer(milliseconds: 500);
  List<Students> findStudents = List();
  List<Students> filteredStudents = List();

  Future studentsAllData;

  TextEditingController _studentId;
  GlobalState _store = GlobalState.instance;

  @override
  void initState(){
    _studentId = new TextEditingController();
    _store.set('studentId', '');
    _store.set('courseId', '');
    _studentId.text = _store.get('studentId');
    _getStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          // future: filteredStudents, //_getStudents(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            
            if(filteredStudents == null) {
              return Container(
                child: Center(
                  child: Text('Cargando...'),
                ),
              );
            } else {
              return Scaffold(
                body: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15.0),
                        hintText: 'Buscar estudiante',
                      ),
                      onChanged: (string) {
                        _debouncer.run(() {
                          setState(() {
                            filteredStudents = findStudents
                                .where((u) => (u.full_name
                                        .toLowerCase()
                                        .contains(string.toLowerCase())))
                                .toList();
                          });
                        });
                      },
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey,
                          ),
                          itemCount: filteredStudents.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage('https://picsum.photos/200/300/?image=$index'),
                              ),
                              trailing: Icon( Icons.keyboard_arrow_right ),
                              title: Text(filteredStudents[index].full_name),
                              subtitle: Text(filteredStudents[index].documento),
                              onTap: (){
                                _store.set('studentId', filteredStudents[index].e_id);
                                Navigator.push(context,
                                  new MaterialPageRoute( builder: (context) => new StudentDetail(filteredStudents[index]))
                                );
                              },
                            );
                          },
                        )
                        ),
                  ],
                ),
              );
            }
          },
        ),
      ),// setScores(),
    );
  }

  Future<List<Students>> _getStudents() async {

    var index = new List();

    var response = await http.get("https://nusoft.education.city/app/test.php");
    data = json.decode(response.body);

    var info = data['ar_enrollments'];

    info.forEach((k,v) => index.add(k));

    List<Students> students = [];

    for (var i = 0; i < info.length; i++) {
      var idx = index[i];
      Students student = Students(info[idx]['e_id'], info[idx]['id_card'], info[idx]['at_id'], info[idx]['lv_id'], info[idx]['group'], info[idx]['enrollment_date'], info[idx]['status'], info[idx]['folio_at_scores'], info[idx]['weekly_load'], info[idx]['enrollment_number'], info[idx]['u_id'], info[idx]['first_name'], info[idx]['last_name'], info[idx]['login'], info[idx]['nid'], info[idx]['nid_city_id'], info[idx]['birth_city_id'], info[idx]['nid_type'], info[idx]['blood_type'], info[idx]['b_id'], info[idx]['p_id'], info[idx]['access_code'], info[idx]['guardian_nid'], info[idx]['guardian_first_name'], info[idx]['guardian_last_name'], info[idx]['folio_enrollment'], info[idx]['enrollment_status'], info[idx]['name'], info[idx]['full_name'], info[idx]['grupo'], info[idx]['estado'], info[idx]['fecha_matricula'], info[idx]['documento'], info[idx]['lastname'], info[idx]['fullname'], info[idx]['nombres'], info[idx]['apellidos']);
      students.add(student);
      setState(() {
        findStudents.add(student);
        filteredStudents = findStudents;
      });
    }
    return students;
  }

}

/* ************************************************************************************************************************ */
/* ************************************************************************************************************************ */
/* ************************************************************************************************************************ */

class StudentDetail extends StatelessWidget {

  var data;

  final Students student;
  StudentDetail(this.student);
    
  GlobalState _store = GlobalState.instance;
  TextEditingController _studentId;

  @override
  void initState(){
    _studentId = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(student.full_name),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 20.0),
              child: CircleAvatar(
                child: Text(student.full_name.substring(0, 2).toUpperCase()),
                backgroundColor: Colors.white,
              ),
            ),            
            onTap: () {
              _showAlert(context);
            },
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _getCourses(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            
            if(snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Cargando...'),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon( Icons.collections_bookmark ),
                    trailing: Icon( Icons.keyboard_arrow_right ),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text('Puntuación ' + snapshot.data[index].score),
                    onTap: (){
                      _store.set('courseId', snapshot.data[index].c_id);
                      Navigator.push(context,
                        new MaterialPageRoute( builder: (context) => StudentCourseDetail(snapshot.data[index]))
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Courses>> _getCourses() async {

    var index = new List();

    var response = await http.get("https://nusoft.education.city/app/test.php");
    data = json.decode(response.body);

    var info = data['ar_courses'];

    info.forEach((k,v) => index.add(k));

    List<Courses> courses = [];

    for (var i = 0; i < info.length; i++) {
      var idx = index[i];
      Courses student = Courses(info[idx]['c_id'], info[idx]['s_id'], info[idx]['at_id'], info[idx]['ev_id'], info[idx]['lev_id'], info[idx]['credits'], info[idx]['weekly_load'], info[idx]['percentage_in_the_area'], info[idx]['mandatory_enrollment'], info[idx]['mandatory_approval'], info[idx]['influences_academic_performance'], info[idx]['allows_score'], info[idx]['has_same_groups_as_level'], info[idx]['final int use_standards'], info[idx]['final int use_assignments'], info[idx]['final int use_massive_assignments'], info[idx]['final int use_comments'], info[idx]['assignments_score_format'], info[idx]['standards_score_format'], info[idx]['final_score_format'], info[idx]['weighting_elements'], info[idx]['weighting_criteria'], info[idx]['order'], info[idx]['always_allow_to_grade'], info[idx]['ar_id'], info[idx]['lv_id'], info[idx]['name'], info[idx]['description'], info[idx]['next_s_id'], info[idx]['prev_s_id'], info[idx]['level_name'], info[idx]['full_name'], info[idx]['spe_id'], info[idx]['allow_different_standards_among_teachers'], info[idx]['scores_range__lower_limit'], info[idx]['scores_range__upper_limit'], info[idx]['scores_range__jump_values_each'], info[idx]['format'], info[idx]['original_final_score_format'], info[idx]['final int year_time_intensity'], info[idx]['score']);
      courses.add(student);
    }
    return courses;
  }

  void _showAlert(BuildContext context) {

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,                    
                    children: <Widget>[
                      Text(
                        'Nombres',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        student.name,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,                    
                    children: <Widget>[
                      Text(
                        'Apellidos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        student.lastname,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,                    
                    children: <Widget>[
                      Text(
                        'Documento',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        student.nid,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,                    
                    children: <Widget>[
                      Text(
                        'Responsable',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        student.guardian_first_name + ' ' + student.guardian_last_name,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,                    
                    children: <Widget>[
                      Text(
                        'Fecha matricula',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        student.enrollment_date,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}

/* ************************************************************************************************************************ */
/* ************************************************************************************************************************ */
/* ************************************************************************************************************************ */

class StudentCourseDetail extends StatelessWidget {

  var data;

  final Courses course;
  StudentCourseDetail(this.course);
    
  GlobalState _store = GlobalState.instance;
  TextEditingController _studentId;

  @override
  void initState(){
    _studentId = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Notas ' + course.full_name),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getScores(_store.get('studentId'), _store.get('courseId')),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            
            if(snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Cargando...'),
                ),
              );
            } else if (snapshot.data.length == 0 ) {
              return AlertDialog(
                title: new Icon( Icons.error_outline, size: 50.0, color: Colors.blue, ),
                content: new Text("El estudiante no tiene notas registradas."),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(20.0),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon( Icons.border_color ),
                    title: Text('Periodo ' + (1+index).toString()),
                    subtitle: Text('Nota definitiva ' + snapshot.data[index].score),
                    onTap: (){
                      /*Navigator.push(context,
                        new MaterialPageRoute( builder: (context) => StudentDetail(snapshot.data[index]))
                      );*/
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<StudentCourse>> _getScores(studentId, courseId) async {

    var index = new List();
    var info;

    var response = await http.get("https://nusoft.education.city/app/test.php");
    data = json.decode(response.body);

    // print('-> estu ' + studentId);
    // print('-> curs ' + courseId);

    if (data['ar_ixc'][studentId] == null || data['ar_ixc'][studentId][courseId] == null) {
      return [];
    }
    
    info = data['ar_ixc'][studentId][courseId];

    info.forEach((k,v) => index.add(k));

    List<StudentCourse> student_course = [];

    for (var i = 0; i < info.length; i++) {
      var idx = index[i];
      // print('-> id ' + idx);
      StudentCourse course_info = StudentCourse(info[idx]['et_id'], info[idx]['e_id'], info[idx]['report_id'], info[idx]['ar_id'], info[idx]['c_id'], info[idx]['absences_justified'], info[idx]['absences_not_justified'], info[idx]['initial_score'], info[idx]['leveling'], info[idx]['score'], info[idx]['comments'], info[idx]['last_updated'], info[idx]['insertion_date']);
      student_course.add(course_info);
    }
    return student_course;
  }

}