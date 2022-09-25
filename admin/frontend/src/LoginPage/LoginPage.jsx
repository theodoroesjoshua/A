import React from 'react';
import { Formik, Field, Form, ErrorMessage } from 'formik';
import * as Yup from 'yup';

import { authenticationService } from '../_services';
import { withRouter } from '../_helpers';

class LoginPageComponent extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    // redirect to home if already logged in
    if (authenticationService.currentUserValue) {
      this.redirect_to_home_page();
    }
  }

  redirect_to_home_page() {
    this.props.navigate('/');
  }

  render() {
    return (
      <div>
          <h2>Login</h2>
          <Formik
              initialValues={{
                  username: '',
                  password: ''
              }}
              validationSchema={Yup.object().shape({
                  username: Yup.string().required('Username is required'),
                  password: Yup.string().required('Password is required')
              })}
              onSubmit={({ username, password }, { setStatus, setSubmitting }) => {
                  setStatus()
                  authenticationService.login(username, password)
                      .then(() => {
                        this.redirect_to_home_page()
                      })
                      .catch((error) => {
                        setSubmitting(false);
                        setStatus(error.response.data.msg);
                      });
                  }}
              render={({ errors, status, touched, isSubmitting }) => (
                  <Form>
                      <div className="form-group">
                          <label htmlFor="username">Username</label>
                          <Field name="username" type="text" className={'form-control' + (errors.username && touched.username ? ' is-invalid' : '')} />
                          <ErrorMessage name="username" component="div" className="invalid-feedback" />
                      </div>
                      <div className="form-group">
                          <label htmlFor="password">Password</label>
                          <Field name="password" type="password" className={'form-control' + (errors.password && touched.password ? ' is-invalid' : '')} />
                          <ErrorMessage name="password" component="div" className="invalid-feedback" />
                      </div>
                      <div className="form-group">
                          <button type="submit" className="btn btn-primary" disabled={isSubmitting}>Login</button>
                          {isSubmitting}
                      </div>
                      {status &&
                          <div className={'alert alert-danger'}>{status}</div>
                      }
                  </Form>
              )}
          />
      </div>
    )
  }
}

export const LoginPage = withRouter(LoginPageComponent);
