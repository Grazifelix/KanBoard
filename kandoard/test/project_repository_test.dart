import 'package:kandoard/model/ProjectModel.dart';
import 'package:kandoard/repositories/ProjectRepository.dart';
import 'package:test/test.dart';
void main() {
  test('Project list should be incremented', (){
    final projectList = ProjectRepository();

    projectList.addProject(ProjectModel('Novo Projeto'));

    expect(projectList.getProjectList.length, 2);
  });
}