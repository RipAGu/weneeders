import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winit/view/project/Search/SearchViewModel.dart';

import 'CustomCheckboxTile.dart';
import 'CustomLocalSelectBtn.dart';
import 'CustomRegionSelectBtn.dart';

class CustomDialogProjectFilter extends StatelessWidget {
  const CustomDialogProjectFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
        builder: (context, viewModel, child) => Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "방식",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            //구분선
                            margin: const EdgeInsets.only(top: 13),
                            height: 1,
                            color: const Color(0xffECECEC),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 13)),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: viewModel.methodList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 5 / 1,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10),
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  child: CustomCheckboxTile(
                                      item: viewModel.methodList[index],
                                      onTap: () => {
                                            viewModel
                                                .toggleProjectFilterCheckBox(
                                                    viewModel
                                                        .methodList[index].idx,
                                                    "method")
                                          }),
                                );
                              }),
                          const Padding(padding: EdgeInsets.only(top: 33)),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "파트너 분야",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            //구분선
                            margin: const EdgeInsets.only(top: 13),
                            height: 1,
                            color: const Color(0xffECECEC),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 13)),
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: viewModel.projectFieldList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 5 / 1,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10),
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  child: CustomCheckboxTile(
                                      item: viewModel.projectFieldList[index],
                                      onTap: () => {
                                            viewModel
                                                .toggleProjectFilterCheckBox(
                                                    viewModel
                                                        .projectFieldList[index]
                                                        .idx,
                                                    "field")
                                          }),
                                );
                              }),
                          const Padding(padding: EdgeInsets.only(top: 33)),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "지역선택",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            //구분선
                            margin: const EdgeInsets.only(top: 13),
                            height: 1,
                            color: const Color(0xffECECEC),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 13)),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: viewModel.area1List.length,
                                      //아이템간의 간격을 조절하는 코드
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: const EdgeInsets.only(top: 2),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.085,
                                          child: CustomLocalSelectBtn(
                                            local: viewModel.area1List[index],
                                            onTap: () => {
                                              viewModel.toggleLocalBtn(index)
                                            },
                                          ),
                                        );
                                      }),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 2)),
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: viewModel.area2List.length,
                                      //아이템간의 간격을 조절하는 코드
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          margin: const EdgeInsets.only(top: 2),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.085,
                                          child: CustomRegionSelectBtn(
                                            region: viewModel.area2List[index],
                                            onTap: () => {
                                              viewModel
                                                  .toggleProjectFilterCheckBox(
                                                      viewModel
                                                          .area2List[index].idx,
                                                      "area")
                                            },
                                          ),
                                        );
                                      }),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  color: const Color(0xff52C0FF),
                  child: TextButton(
                    onPressed: () {
                      viewModel.projectList.clear();
                      viewModel.page = 1;
                      viewModel.getProjectList();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "검색",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }
}
