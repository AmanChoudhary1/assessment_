import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/assessment_model.dart';
import '../../data/repositories/assessment_repository.dart';
import '../../domain/usecases/get_assessments_use_case.dart';
import '../bloc/assessment_bloc.dart';
import '../bloc/assessment_event.dart';
import '../bloc/assessment_state.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'widgets/categoryItem_widget.dart';
import 'widgets/recentlyTakenItem_widget.dart';
import 'widgets/topPickItem_widget.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final assessmentRepository = AssessmentRepository();
    final getAssessmentsUseCase = GetAssessmentsUseCase(assessmentRepository);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Text(
            'Self Assessments',
            style: TextStyle(fontSize: 16.0),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: const [
            Icon(Icons.help_rounded, color: Colors.indigoAccent, size: 24),
            SizedBox(
              width: 5.0,
            ),
            Icon(Icons.home_rounded, size: 24, color: Colors.indigoAccent),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) =>
              AssessmentBloc(getAssessmentsUseCase)..add(LoadAssessments()),
          child: BlocBuilder<AssessmentBloc, AssessmentState>(
            builder: (context, state) {
              if (state is AssessmentLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AssessmentLoaded) {
                return _buildAssessmentUI(context, state.categories,
                    state.topPicks, state.recentlyTaken, screenSize);
              } else if (state is AssessmentError) {
                return const Center(child: Text('Error loading assessments'));
              }
              return const Center(child: Text('Unknown state'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAssessmentUI(
      BuildContext context,
      List<AssessmentModel> categories,
      List<TopPickModel> topPicks,
      List<RecentlyTakenModel> recentlyTaken,
      Size screenSize) {
    return ColoredBox(
      color: Colors.grey.shade200,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        children: [
          Column(
            children: [
              SizedBox(height: screenSize.height * 0.03),
              const Text(
                "Good Morning Reuben!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: screenSize.height * 0.01),
              SizedBox(
                width: screenSize.width * 0.8,
                child: Text(
                  "Welcome to our free self-assessments! Take charge of your mental health and well-being by exploring this insightful evaluations",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
            ],
          ),
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                height: screenSize.height,
                width: screenSize.width,
                margin: const EdgeInsets.only(top: 30),
              ),
              Column(
                children: [
                  SizedBox(
                    width: screenSize.width * 0.8,
                    child: _buildSectionRecent(
                        'Recent Test', 'Self Discovery Assessment', '65'),
                  ),
                  const SizedBox(height: 8),
                  _buildSectionTitle('Categories'),
                  const SizedBox(height: 8),
                  _buildCategoriesSection(categories, screenSize),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Top Picks'),
                  const SizedBox(height: 8),
                  _buildTopPicksSection(topPicks, screenSize),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Recently Taken'),
                  const SizedBox(height: 8),
                  _buildRecentlyTakenSection(recentlyTaken, screenSize),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSectionRecent(title, subtitle, progress) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14))),
      color: Colors.indigoAccent.shade200,
      child: ListTile(
        minVerticalPadding: 15,
        trailing: CircularPercentIndicator(
          radius: 25.0,
          lineWidth: 5,
          percent: 0.4,
          center: Text(
            "$progress%",
            style: const TextStyle(fontSize: 12.0, color: Colors.white),
          ),
          progressColor: Colors.white,
        ),
        titleTextStyle: const TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
        subtitleTextStyle: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300),
        title: Text(title),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              const Icon(
                Icons.lightbulb_outlined,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 5),
              Text(subtitle),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      trailing: const Text(
        "View All",
        style: TextStyle(color: Colors.black45),
      ),
    );
  }

  Widget _buildCategoriesSection(
      List<AssessmentModel> categories, Size screenSize) {
    return SizedBox(
      height: screenSize.height * 0.18,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) {
          return CategoryItem(
            icon: categories[index].icon,
            title: categories[index].category,
            quizzes: categories[index].quizzes,
          );
        },
      ),
    );
  }

  Widget _buildTopPicksSection(List<TopPickModel> topPicks, screenSize) {
    return TopPickItem(topPicks: topPicks, screenSize: screenSize);
  }

  Widget _buildRecentlyTakenSection(
      List<RecentlyTakenModel> recentlyTaken, screenSize) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: recentlyTaken.length,
        itemBuilder: (context, index) {
          return RecentlyTakenItem(
            image: recentlyTaken[index].image,
            title: recentlyTaken[index].title,
            dateTaken: recentlyTaken[index].dateTaken,
            screenSize: screenSize,
          );
        },
      ),
    );
  }
}
