import 'package:flutter/material.dart';
import 'package:kandoard/components/project_card.dart';
import 'package:kandoard/controller/textfield_controller.dart';
import 'package:kandoard/model/ProjectModel.dart';
import 'package:kandoard/repositories/ProjectRepository.dart';
import 'package:kandoard/shared/app_colors.dart';
import 'package:provider/provider.dart';

class ProjectsView extends StatelessWidget {
  const ProjectsView({super.key});
  static const routeName = '/projetos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        title: const Text(
          'KanBoard',
          style: TextStyle(
              color: Color(0xFFD9D9D9),
              fontSize: 24,
              fontWeight: FontWeight.w200,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: AppColors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
            child: Column(
          children: [
            SizedBox(
                height: 54,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: AppColors.blue,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 26.0, right: 26.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Criar Novo Projeto',
                            style: TextStyle(
                                color: Color.fromARGB(255, 52, 52, 52),
                                fontSize: 24,
                                fontWeight: FontWeight.w300),
                          ),
                          Icon(Icons.add,
                              color: Color.fromARGB(255, 52, 52, 52)),
                        ],
                      ),
                    ),
                    onPressed: () {
                    
                      addProjectModal(context);
                      
                    })),
            const SizedBox(
              height: 56,
            ),
            Consumer<ProjectRepository>(builder: (context, value, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: value.getProjectList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: ProjectCard(
                        projectName: value.getProjectList[index].nameProject,
                        cardContent: value.getProjectList[index],
                      ),
                    );
                  },
                ),
              );
            })
          ],
        )),
      ),
    );
  }

  Future<void> addProjectModal(BuildContext context) {
    final nameProjectInput = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: AppColors.grey,
              title: const Text(
                'Criar Novo Projeto',
                style: TextStyle(color: Color(0xFF7398C8)),
              ),
              content: SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<TextFieldController>(
                        builder: (context, errorValue, child) {
                      return TextFormField(
                        style: TextStyle(color: AppColors.white),
                        controller: nameProjectInput,
                        decoration: InputDecoration(
                            errorText: errorValue.errorInput.isEmpty
                                ? null
                                : errorValue.errorInput,
                            labelText: 'Nome do Projeto',
                            labelStyle: TextStyle(
                              color: AppColors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            height: 54,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: AppColors.blue,
                                ),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Text(
                                    'Criar',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 52, 52, 52),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                onPressed: () {
                                  final errorLabel =
                                      context.read<TextFieldController>();
                                  if (nameProjectInput.text.isEmpty) {
                                    
                                    errorLabel
                                        .setErrorMenssage('Digite um nome para o projeto');
                                  } else {
                                    final projectsList =
                                        context.read<ProjectRepository>();
                                    errorLabel.setErrorMenssage('');

                                    projectsList.addProject(
                                        ProjectModel(nameProjectInput.text));

                                    Navigator.of(context).pop();
                                  }
                                })),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                            height: 54,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(color: AppColors.blue),
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: AppColors.grey,
                                ),
                                child: const Padding(
                                  padding:
                                      EdgeInsets.only(left: 5.0, right: 5.0),
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(
                                        color: Color(0xFF7398C8),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                onPressed: () {
                                  final errorLabel =
                                      context.read<TextFieldController>();
                                  if (errorLabel.errorInput != '') {
                                    errorLabel.setErrorMenssage('');
                                  }
                                  Navigator.of(context).pop();
                                }))
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}