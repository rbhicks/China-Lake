# Copyright 2015 Ryan B. Hicks
#
# 

exposureAnalysisNumericalResultsSub = Meteor.subscribe('exposure_analysis_numerical_results')

Template.exposureGauge.created = ->
#        analysisUuid = Meteor.uuid()
        analysisUuid = '6b040e80-de5f-4bb9-b807-2f1f1cf17b91'
        console.log(analysisUuid)
        Session.set('analysisUuid', analysisUuid)


Template.exposureGauge.rendered = ->
        gauge = new JustGage
                id: "gauge"
                value: 0
                min: 0
                max: 100
                title: "How Exposed You Are"
                label: ""
                levelColorsGradient: false 

        Tracker.autorun((->
                analysisUuid                            = Session.get('analysisUuid')
                currentExposureAnalysisNumericalResults = ExposureAnalysisNumericalResults.findOne({exposure_analysis_uuid: analysisUuid})


                if exposureAnalysisNumericalResultsSub.ready() and currentExposureAnalysisNumericalResults
                    synthesizedExposureStatusValue = Math.round(100 * currentExposureAnalysisNumericalResults.synthesized_exposure_status_value)
                    gauge.refresh(synthesizedExposureStatusValue)
            ).bind(this))


