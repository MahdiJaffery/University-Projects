#include"LoginForm.h"
#include"MainForm.h"
#include"RegisterForm.h"
#include"Analytics.h"
#include"BloodDisorders.h"
#include"BloodFacts.h"
#include"BloodRequest.h"
#include"ContactUs.h"
#include"Leaderboard.h"
#include"ThingsToKnow.h"
#include"Visit.h"
#include"Compatibility.h"


using namespace System;
using namespace System::Windows::Forms;

void main(array<String^>^ args) {
	Application::EnableVisualStyles();
	Application::SetCompatibleTextRenderingDefault(false);

	User^ user = nullptr;
	while (true) {
		Testing::LoginForm loginform;
		loginform.ShowDialog();

		if (loginform.switchToRegister) {
			Testing::RegisterForm registerform;
			registerform.ShowDialog();

			if (registerform.switchToLogin) {
				continue;
			}
			else {
				user = registerform.user;
				break;
			}

		}
		else {
			user = loginform.user;
			break;
		}
	}

	if (user != nullptr) {
		while (true) {
			Testing::MainForm mainform(user), analytics(user), bloodreq(user), leaderboard(user), bloodfacts(user), thingstoknow(user), blooddisorders(user),
				bookavisit(user), contactus(user), compatibility(user);
			mainform.ShowDialog();

			if (mainform.endProgram) {
				break;
			}
			// Blood Requests
			if (mainform.switchToBloodRequests) {
				Testing::BloodRequest bloodreq;
				bloodreq.ShowDialog();

				if (bloodreq.switchToMainForm) {
					continue;
				}
				else {
					user = mainform.user;
					break;
				}
			}
			else {
				user = bloodreq.user;
			}

			//Analytics
			if (mainform.switchToAnalytics) {
				Testing::Analytics analytics;
				analytics.ShowDialog();

				if (analytics.switchToMainForm) {
					continue;
				}
				else {
					user = mainform.user;
					break;
				}
			}
			else {
				user = analytics.user;
			}

			//Leaderboard
			if (mainform.switchToLeaderboard) {
				Testing::Leaderboard leaderboard;
				leaderboard.ShowDialog();

				if (leaderboard.switchToMainForm) {
					continue;
				}
				else {
					user = mainform.user;
					break;
				}
			}
			else {
				user = leaderboard.user;
			}

			//Blood Facts
			if (mainform.switchToBloodFacts) {
				Testing::BloodFacts bloodfacts;
				bloodfacts.ShowDialog();

				if (bloodfacts.switchToMainForm) {
					continue;
				}
				else {
					user = mainform.user;
					break;
				}
			}
			else {
				user = bloodfacts.user;
			}

			//Things to Know
			if (mainform.switchToABD) {
				Testing::ThingsToKnow thingstoknow;
				thingstoknow.ShowDialog();

				if (thingstoknow.switchToMainForm) {
					continue;
				}
				else {
					user = mainform.user;
					break;
				}
			}
			else {
				user = thingstoknow.user;
			}

			//Blood Disorders
			if (mainform.switchToBloodDisorders) {
				Testing::BloodDisorders blooddisorders;
				blooddisorders.ShowDialog();

				if (blooddisorders.switchToMainForm) {
					continue;
				}
				else {
					user = mainform.user;
					break;
				}
			}
			else {
				user = blooddisorders.user;
			}

			//Book a Visit
			if (mainform.switchToBookAVisit) {
				Testing::Visit bookavisit;
				bookavisit.ShowDialog();

				if (bookavisit.switchToMainForm) {
					continue;
				}
				else {
					user = mainform.user;
					break;
				}
			}
			else {
				user = bookavisit.user;
			}

			//Contact Us
			if (mainform.switchToContactUs) {
				Testing::ContactUs contactus;
				contactus.ShowDialog();

				if (contactus.switchToMainForm) {
					continue;
				}
				else {
					user = mainform.user;
					break;
				}
			}
			else {
				user = contactus.user;
			}

			////Compatibility
			if (mainform.switchToCompatibility) {
				Testing::Compatibility compatibility;
				compatibility.ShowDialog();

				if (compatibility.switchToDashboard) {
					continue;
				}
				else {
					user = mainform.user;
					break;
				}
			}
			else {
				user = compatibility.user;
			}
		}
	}
	else {
		MessageBox::Show("Authentication Cancelled", "Program.cpp", MessageBoxButtons::OK);
	}
}