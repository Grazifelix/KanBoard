import 'package:flutter/material.dart';
import 'package:kandoard/controller/textfield_controller.dart';
import 'package:kandoard/shared/app_colors.dart';
import 'package:provider/provider.dart';

import '../provider/workspace_provider.dart';

Future<void> addWorkspaceDialog(BuildContext context) {
  final workspaceInput = TextEditingController();

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.grey,
          title: const Text(
            'Criar Novo Projeto',
            style: TextStyle(color: Color(0xFF7398C8)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<TextFieldController>(
                  builder: (context, errorValue, child) {
                return Column(
                  children: [
                    TextFormField(
                      style: TextStyle(color: AppColors.white),
                      controller: workspaceInput,
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
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    
                  ],
                );
              }),
              const SizedBox(height: 40),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 54,
                    width: 120,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: AppColors.blue,
                        ),
                        child: const Text(
                          'Criar',
                          style: TextStyle(
                              color: Color.fromARGB(255, 52, 52, 52),
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                        onPressed: () {
                          final errorLabel =
                              context.read<TextFieldController>();
                          // TODO: tirar essa lógica daqui de dentro
                          //TODO: adicionar logica de que não pode adicionar dois boards com mesmo nome
                          if (workspaceInput.text.isEmpty) {
                            errorLabel.setErrorMenssage(
                                'Digite um nome para o Projeto');
                          } else if (workspaceInput.text.length < 3) {
                            errorLabel.setErrorMenssage(
                                'Digite ao menos 3 caracteres');
                          } else {
                            final projectsList =
                                context.read<WorkspaceProvider>();
                            errorLabel.setErrorMenssage('');

                            projectsList
                                .addBoardToWorkspace(workspaceInput.text);

                            Navigator.of(context).pop();
                          }
                        }),
                  ),
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
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                              color: Color(0xFF7398C8),
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                        onPressed: () {
                          final errorLabel =
                              context.read<TextFieldController>();
                          if (errorLabel.errorInput != '') {
                            errorLabel.setErrorMenssage('');
                          }
                          Navigator.of(context).pop();
                        }),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
